//
//  StockAvgViewController.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/09.
//

import UIKit

class StockAvgViewController : UIViewController
{
    @IBOutlet weak var currentHoldStock: UITextField!   // 현재 보유주식
    @IBOutlet weak var currentStockAvg: UITextField!    // 현재 평단가
    @IBOutlet weak var currentAvgPrice: UITextField!    // 현재 주식의 총합
    
    @IBOutlet weak var buyingStock: UITextField!        // 구매할 주식 수
    @IBOutlet weak var buyingStockPrice: UITextField!   // 구매할 가격
    @IBOutlet weak var buyingAllPrice: UITextField!     // 구매한 총합
    
    // MARK: StockAvgViewController Class Variable Group
    
    var currentHoldEditting = false
    var currentStockAvgEditting = false
    var buyingStockEditting = false
    var buyingStockPriceEditting = false
    
    // MARK: StockAvgViewController Class Function Group
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func TextFieldZeroInitialize(_ tf : UITextField) -> Bool{
        tf.text = ""
        return false
    }
    
    func HoldAllPriceCalculate(){
        
        var allPrice: Double = 0.0
        allPrice = (currentHoldStock.text! as NSString).doubleValue * (currentStockAvg.text! as NSString).doubleValue
        
        currentAvgPrice.text = "현재 보유 주식금액 : \(allPrice)"
    }
    
    func buyingAllPriceCalculate(){
        
        var allPrice: Double = 0.0
        allPrice = (buyingStock.text! as NSString).doubleValue * (buyingStockPrice.text! as NSString).doubleValue
        
        buyingAllPrice.text = "매수 필요 금액 : \(allPrice)"
    }
    
    // MARK: StockAvgViewController Class IBAction Group
    
    
    // 첫 번째 텍스트 필드
    @IBAction func currentHoldStockTextField(_ sender: Any){
        if let text = currentHoldStock.text{
            if text.count > 0 && currentHoldEditting == false{
                currentHoldEditting = true
            }
        }
        
        if currentHoldStock.text!.count <= 0{
            currentHoldEditting = TextFieldZeroInitialize(currentAvgPrice)
        }
        
        if currentHoldEditting && currentStockAvgEditting
        {
            HoldAllPriceCalculate()
        }
    }
    
    // 두 번째 텍스트 필드
    @IBAction func currentStockAvgTextField(_ sender: Any){
        if let text = currentStockAvg.text{
            if text.count > 0 && currentStockAvgEditting == false{
                currentStockAvgEditting = true
            }
        }
        
        if currentStockAvg.text!.count <= 0{
            currentStockAvgEditting = TextFieldZeroInitialize(currentAvgPrice)
        }
        
        if currentHoldEditting && currentStockAvgEditting
        {
            HoldAllPriceCalculate()
        }
    }
    
    // 세 번째 텍스트 필드
    @IBAction func buyingTextField(_ sender: Any){
        if let text = buyingStock.text{
            if text.count > 0 && buyingStockEditting == false{
                buyingStockEditting = true
            }
        }
        
        if buyingStock.text!.count <= 0{
            buyingStockEditting = TextFieldZeroInitialize(buyingAllPrice)
        }
        
        if buyingStockEditting && buyingStockPriceEditting
        {
            buyingAllPriceCalculate()
        }
    }
    
    // 네 번째 텍스트 필드
    @IBAction func buyingPriceTextField(_ sender: Any){
        if let text = buyingStockPrice.text{
            if text.count > 0 && buyingStockPriceEditting == false{
                buyingStockPriceEditting = true
            }
        }
        
        if buyingStockPrice.text!.count <= 0{
            buyingStockPriceEditting = TextFieldZeroInitialize(buyingAllPrice)
        }
        
        if buyingStockEditting && buyingStockPriceEditting
        {
            buyingAllPriceCalculate()
        }
    }
    
    // 계산 버튼
    @IBAction func AvgCalculator(_ sender: Any)
    {
        var title = ""
        var msg = ""
        
        if !currentHoldEditting || !currentStockAvgEditting || !buyingStockEditting || !buyingStockPriceEditting{
            title = "비어있는 칸이 있습니다."
            msg = "확인하시고 채워 주세요"
        }
        else
        {
            title = "평단가 계산"
            let allStock = (buyingStock.text! as NSString).intValue + (currentHoldStock.text! as NSString).intValue
            let price = ((currentHoldStock.text! as NSString).doubleValue * (currentStockAvg.text! as NSString).doubleValue) + ((buyingStock.text! as NSString).doubleValue * (buyingStockPrice.text! as NSString).doubleValue)
            msg = "구매시 보유하게 될 주식의 수는 \(allStock)주이며\n모든 주식 구매에 사용하게 되는 금액은 \(price)원이고\n평단가는 \(price/Double(allStock)) 입니다."
        }
        
        MyCustomClass.showAlert(viewController: self, title: title, msg: msg, buttonTitle: "확인", handler: nil)
    }
}
