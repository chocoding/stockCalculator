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
    
    // MARK: Variable
    
    var holdStockInput = false, avgPriceInput = false, sellPriceInput = false
    var _holdStockPrice : Int64 = 0
    var _avgPrice = 0.0, _sellPrice = 0.0
    
    // MARK: Function
    
    func textFieldIntialize() -> Bool{
        koreaRevenue.text = ""
        usRevenue.text = ""
        return false
    }
    
    func revenueCalculate(){
        
        let nF = NumberFormatter()
        nF.numberStyle = .decimal
        
        let avgRevenue = Double(_holdStockPrice) * _avgPrice
        let sellRevenue = Double(_holdStockPrice) * _sellPrice
        
        let result = nF.string(from: NSNumber(value: sellRevenue - avgRevenue))
        koreaRevenue.text = "\(result ?? "0") ₩"
        
        // 미국 주식 업뎃하자!
        usRevenue.text = "미국 주식 수익은 업뎃 예정입니다."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
