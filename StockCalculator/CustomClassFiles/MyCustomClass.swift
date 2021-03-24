//
//  MyCustomClass.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/09.
//

import UIKit

class MyCustomClass
{
    private var stockDic : [StockInfo] = []
    private var exchange : String = ""
    
    class func showAlert(viewController: UIViewController?,title: String, msg: String, buttonTitle: String, handler: ((UIAlertAction) -> Swift.Void)?){
            
          let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            
          let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
          alertController.addAction(defaultAction)
        
          viewController?.present(alertController, animated: true, completion: nil)
    }
    
    class func textFieldIntegerComma(_ txt: String, _ uiTextField: UITextField) -> Int64{
        let nF = NumberFormatter()
        nF.numberStyle = .decimal
        
        let tfStr = Int64(txt.replacingOccurrences(of: ",", with: ""))
        uiTextField.text = nF.string(from: NSNumber(value: tfStr!))!
        
        return Int64((uiTextField.text?.replacingOccurrences(of: ",", with: ""))!)!
    }
}


// Local Json File
extension MyCustomClass
{
    func readLocalFile(name: String) -> Data?{
        do{
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"){
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
                return jsonData
            }
        }catch{
            print(error)
        }
        
        return nil
    }
    
    func internalJson(jsonData: Data){
        do{
            let decodeData = try JSONDecoder().decode([StockInfo].self, from: jsonData)
            stockDic = decodeData
        }catch{
            print(error)
        }
    }
    
    func getStockDic() -> [StockInfo]{
        return stockDic
    }
}

struct StockInfo : Codable{
    let name: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey{
        case name
        case code
    }
}

// url json Exchange
extension MyCustomClass
{
    func exchangeJson(){
        let authkey = "PhxD1fdwzYtld5yjtb4udygGiSuDdhiY"
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let cur_Date = df.string(from: Date())
        let str = Int(cur_Date.replacingOccurrences(of: "-", with: ""))! - 1
        let url = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=\(authkey)&searchdate=\(str)&data=AP01"
        
        URLSession.shared.dataTask(with: URL(string: url)!){ (data, response, error) in
            if let dataJson = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Array<Dictionary<String,Any>>
                    for jsonExchange in json{
                        if jsonExchange["cur_unit"]! as! String == "USD"{
                            self.exchange = jsonExchange["deal_bas_r"]! as! String
                        }
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
    
    func getExchangeData() -> String{
        return exchange
    }
}
