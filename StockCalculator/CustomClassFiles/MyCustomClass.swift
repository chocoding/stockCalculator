//
//  MyCustomClass.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/09.
//

import UIKit

class MyCustomClass
{
    class func showAlert(viewController: UIViewController?,title: String, msg: String, buttonTitle: String, handler: ((UIAlertAction) -> Swift.Void)?){
            
          let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            
          let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
          alertController.addAction(defaultAction)
        
          viewController?.present(alertController, animated: true, completion: nil)
    }
}

extension String{
    var insertComma: String
    {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let _ = self.range(of: "."){
            
            var numberArray = self.components(separatedBy: ".")
            
            if numberArray.count == 1{
                var numberString = numberArray[0]
                if numberString.isEmpty{
                    numberString = "0"
                }
                
                guard let doubleValue = Double(numberString) else{
                    return self
                }
                
                return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
            }
            else if numberArray.count == 2{
                var numberString = numberArray[0]
                if numberString.isEmpty{
                    numberString = "0"
                }
                
                guard let doubleValue = Double(numberString) else{
                    return self
                }
                
                return (numberFormatter.string(from: NSNumber(value: doubleValue)) ?? numberString) + ".\(numberArray[1])"
            }
            else{
                guard let doubleValue = Double(self) else
                {
                    return self
                }
                
                return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
            }
        }
        return self
    }
}
