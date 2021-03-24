//
//  DebateViewController.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/13.
//

import UIKit

class DebateViewController : UIViewController
{
    // MARK: Variable
    
    @IBOutlet weak var debateTextfield: UITextField!
    
    var myCustomClass = MyCustomClass()
    
    // MARK: Function
    
    func openURL(_ url: String){
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func stockCodeOutput(_ code: String) -> String{
        var returnCode = ""
        if code.count < 6{
            if code.count <= 1{
                returnCode = "00000" + code
            }
            else if code.count <= 2{
                returnCode = "0000" + code
            }
            else if code.count <= 3{
                returnCode = "000" + code
            }
            else if code.count <= 4{
                returnCode = "00" + code
            }
            else if code.count <= 5{
                returnCode = "0" + code
            }
        }
        else{
            returnCode = code
        }
        
        return returnCode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCustomClass.internalJson(jsonData: myCustomClass.readLocalFile(name: "StockJson")!)
    }
    
    // MARK: Action Function
    
    @IBAction func koreaDebateAction(_ sender: Any) {
        var code: String = ""
        if let text = debateTextfield.text{
            for dic in myCustomClass.getStockDic(){
                if dic.name == text{
                   code = stockCodeOutput(dic.code!)
                }
                else if dic.code == text{
                   code = stockCodeOutput(dic.code!)
                }
            }
            
            if code == ""{
                code = "005930"
            }
            
            let combineURL = "https://finance.naver.com/item/board.nhn?code=\(code)"
            openURL(combineURL)
            
            debateTextfield.text = ""
        }
    }
    
    @IBAction func usDebateAction(_ sender: Any) {
        if let text = debateTextfield.text?.uppercased(){
            let combineURL = "https://m.stock.naver.com/index.html#/worldstock/stock/\(text)/discuss"
            openURL(combineURL)
            debateTextfield.text = ""
        }
    }
    
    @IBAction func shortInterestAction(_ sender: Any) {
        if let text = debateTextfield.text?.uppercased(){
            let combineURL = "https://iborrowdesk.com/report/\(text)"
            openURL(combineURL)
            debateTextfield.text = ""
        }
    }
}
