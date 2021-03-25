//
//  StockRevenueViewController.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/09.
//

import UIKit

class StockRevenueViewController : UIViewController
{
    @IBOutlet weak var holdStock: UITextField!
    @IBOutlet weak var avgPrice: UITextField!
    @IBOutlet weak var sellPrice: UITextField!
    
    @IBOutlet weak var koreaRevenue: UITextField!
    @IBOutlet weak var usRevenue: UITextField!
    
    @IBOutlet weak var usLabel: UILabel!
    // MARK: Variable
    
    var holdStockInput = false, avgPriceInput = false, sellPriceInput = false
    var _holdStockPrice : Int64 = 0
    var _avgPrice = 0.0, _sellPrice = 0.0
    var exc = 0.0
    
    var myCustomClass = MyCustomClass()
    var exchange = ""
    
    // MARK: Function
    
    func textFieldIntialize() -> Bool{
        koreaRevenue.text = ""
        usRevenue.text = ""
        return false
    }
    
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
    
    func revenueCalculate(){
        let nF = NumberFormatter()
        nF.numberStyle = .decimal
        nF.maximumFractionDigits = 1
        nF.minimumFractionDigits = 1
        
        let avgRevenue = Double(_holdStockPrice) * _avgPrice
        let sellRevenue = Double(_holdStockPrice) * _sellPrice
        
        let result = nF.string(from: NSNumber(value: sellRevenue - avgRevenue))
        koreaRevenue.text = "\(result ?? "0") ₩"
        
        var usResult = ""
        var usRevenueResult = (sellRevenue - avgRevenue) * exc
        if usRevenueResult > 2500000{
            let usTex = (usRevenueResult - 2500000) * 0.22
            usRevenueResult = (usRevenueResult) - usTex
            usResult = nF.string(from: NSNumber(value: usRevenueResult))!
            usRevenue.text = "양도소득세 계산포함 : \(usResult) ₩"
        }
        else{
            usResult = nF.string(from: NSNumber(value: usRevenueResult))!
            usRevenue.text = "\(usResult) ₩"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.exc = Double(self.exchange.replacingOccurrences(of: ",", with: "")) ?? 0.0
            self.usLabel.text = "미국 주식 수익금 (현재 환율 : \(self.exc))"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeJson()
        holdStock.addTarget(self, action: #selector(holdStockSelector), for: .editingChanged)
        avgPrice.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        sellPrice.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func holdStockSelector(_ textField: UITextField){
        if let text = textField.text{
            if text.count > 0{
                holdStockInput = true
                _holdStockPrice = MyCustomClass.textFieldIntegerComma(text, holdStock)
            }
        }
        
        if textField.text!.count <= 0{
            holdStockInput = textFieldIntialize()
        }
        
        if holdStockInput && avgPriceInput && sellPriceInput{
            revenueCalculate()
        }
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField){
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
            
            if textField == avgPrice{
                _avgPrice = Double(amountString.replacingOccurrences(of: ",", with: "")) ?? 0.0
                avgPriceInput = true
            }
            else{
                _sellPrice = Double(amountString.replacingOccurrences(of: ",", with: "")) ?? 0.0
                sellPriceInput = true
            }
        }
        
        if avgPrice.text!.count <= 0{
            avgPriceInput = textFieldIntialize()
        }
        
        if sellPrice.text!.count <= 0{
            sellPriceInput = textFieldIntialize()
        }
        
        if holdStockInput && avgPriceInput && sellPriceInput{
            revenueCalculate()
        }
    }
}
