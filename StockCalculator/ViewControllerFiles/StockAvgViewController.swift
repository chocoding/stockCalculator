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
    
    // 텍스트 필드에서의 입력이 끝나면, true 비어있다면, false로 해서 입력이 비어있는 지를 체크하는 변수이다.
    var currentHoldEditting = false
    var currentStockAvgEditting = false
    var buyingStockEditting = false
    var buyingStockPriceEditting = false
    
    var _currentHoldStock: Int64 = 0
    var _buyingStock: Int64 = 0
    var _currentStockAvg: Double = 0.0
    var _buyingStockPrice: Double = 0.0
    
    
    
    // MARK: StockAvgViewController Class Function Group
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        currentStockAvg.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        buyingStockPrice.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
            
            if textField == currentStockAvg{
                _currentStockAvg = Double(amountString.replacingOccurrences(of: ",", with: "")) ?? 0.0
            }
            else{
                _buyingStockPrice = Double(amountString.replacingOccurrences(of: ",", with: "")) ?? 0.0
            }
        }
    }
    
    // 입력 가능한 텍스트 필드가 비어있다면, 총 가격에 대한 텍스트 필드를 비워주고, Bool값의 false를 리턴한다.
    func TextFieldZeroInitialize(_ tf : UITextField) -> Bool{
        tf.text = ""
        return false
    }
    
    // 보유 평단가에 대한 총 가격을 계산하는 함수
    func HoldAllPriceCalculate(){
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        var allPrice: Double = 0.0
        allPrice = Double(_currentHoldStock) * _currentStockAvg
        
        let result = numberFormatter.string(from: NSNumber(value: allPrice))
        
        currentAvgPrice.text = "현재 보유 주식금액 : \(result ?? "")"
    }
    
    // 매수에 필요한 총 금액을 계산하는 함수
    func buyingAllPriceCalculate(){
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        var allPrice: Double = 0.0
        allPrice = Double(_buyingStock) * _buyingStockPrice
        
        let result = numberFormatter.string(from: NSNumber(value: allPrice))
        
        buyingAllPrice.text = "매수 필요 금액 : \(result ?? "")"
    }
    
    // MARK: StockAvgViewController Class IBAction Group
    
    // 첫 번째 텍스트 필드
    @IBAction func currentHoldStockTextField(_ sender: Any) {
        // UITextField의 text는 옵셔널이기 때문에, 바인딩을 하고, 해당 텍스트 필드에 값이 있고 currentHoldEditting이 false라면, currentHoldEditting을 true로 만든다.
        if let text = currentHoldStock.text{
            if text.count > 0 {
                
                let nF = NumberFormatter()
                nF.numberStyle = .decimal
                
                let tfStr = Int64(text.replacingOccurrences(of: ",", with: ""))
                currentHoldStock.text = nF.string(from: NSNumber(value: tfStr!))!
                
                _currentHoldStock = Int64((currentHoldStock.text?.replacingOccurrences(of: ",", with: ""))!)!
                
                currentHoldEditting = true
            }
        }
        
        // 만약, 텍스트필드의 text가 비어있다면, 총 금액에 대한 텍스트필드와 bool값을 초기화한다.
        if currentHoldStock.text!.count <= 0{
            currentHoldEditting = TextFieldZeroInitialize(currentAvgPrice)
        }
        
        // View에 있는, 입력 가능한 텍스트 필드가 모두 입력이 되어 있다면, 총 금액을 계산해서 출력한다.
        if currentHoldEditting && currentStockAvgEditting
        {
            HoldAllPriceCalculate()
        }
    }
    
    // 두 번째 텍스트 필드
    @IBAction func currentStockAvgTextField(_ sender: Any) {
        if let text = currentStockAvg.text{
            if text.count > 0 {
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
    @IBAction func buyingTextField(_ sender: Any) {
        if let text = buyingStock.text{
            if text.count > 0{
                
                let nF = NumberFormatter()
                nF.numberStyle = .decimal
                
                let tfStr = Int64(text.replacingOccurrences(of: ",", with: ""))
                buyingStock.text = nF.string(from: NSNumber(value: tfStr!))!
                
                _buyingStock = Int64((currentHoldStock.text?.replacingOccurrences(of: ",", with: ""))!)!
                
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
    @IBAction func buyingPriceTextField(_ sender: Any) {
        if let text = buyingStockPrice.text{
            if text.count > 0{
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
        // title, msg 라는 String 자료형 변수를 선언, 이 변수는 알림창의 타이틀과 메시지에 이용된다.
        var title = ""
        var msg = ""
        
        // 만약 네개의 텍스트 필드 중 하나라도 비어있다면, 비어있는 칸이 있다는 것을 알림창을 알려준다.
        if !currentHoldEditting || !currentStockAvgEditting || !buyingStockEditting || !buyingStockPriceEditting{
            title = "비어있는 칸이 있습니다."
            msg = "확인하시고 채워 주세요"
        }
        else
        {
            title = "평단가 계산"    // 타이틀은 평단가 계산
            
            // 매수를 하게 될 경우, 보유 주식과 매수 하게 될 주식 수를 더해서 allStock에 대입
            let allStock = (buyingStock.text! as NSString).longLongValue + (currentHoldStock.text! as NSString).longLongValue
            
            // 매수를 하게 될 경우, 보유 주식과 매수 하게 될 주식의 총 가격을 price에 대입
            let price = ((currentHoldStock.text! as NSString).doubleValue * (currentStockAvg.text! as NSString).doubleValue) + ((buyingStock.text! as NSString).doubleValue * (buyingStockPrice.text! as NSString).doubleValue)
            
            // 총 가격과 총 보유 주식을 나눠 avgPrice에 대입하면, 이건 평단가를 뜻한다.
            let avgPrice =  price/Double(allStock)
            
            // NumberFormatter를 이용해서, 3자리수로 콤마를 붙인다.
            let nF = NumberFormatter()
            nF.numberStyle = .decimal
            
            let allStockStr = nF.string(from: NSNumber(value: allStock))!
            let priceStr = nF.string(from: NSNumber(value: price))!
            let avgPriceStr = nF.string(from: NSNumber(value: avgPrice))!
            
            msg = "구매시 보유하게 될 주식의 수는 \(allStockStr)주이며\n모든 주식 구매에 사용하게 되는 금액은 \(priceStr)원이고\n평단가는 \(avgPriceStr)원 입니다."
        }
        
        // title과 msg에 있는 값으로 알림창을 띄운다.
        MyCustomClass.showAlert(viewController: self, title: title, msg: msg, buttonTitle: "확인", handler: nil)
    }
}

extension String {

// formatting text for currency textField
func currencyInputFormatting() -> String {

    var number: NSNumber!
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal//.currencyAccounting
    //formatter.currencySymbol = "$"
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2

    var amountWithPrefix = self

    let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
    amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

    let double = (amountWithPrefix as NSString).doubleValue
    number = NSNumber(value: (double / 100))


    guard number != 0 as NSNumber else {
        return ""
    }

    return formatter.string(from: number)!
}
}
