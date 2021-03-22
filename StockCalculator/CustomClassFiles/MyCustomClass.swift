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
    
    class func textFieldIntegerComma(_ txt: String, _ uiTextField: UITextField) -> Int64{
        let nF = NumberFormatter()
        nF.numberStyle = .decimal
        
        let tfStr = Int64(txt.replacingOccurrences(of: ",", with: ""))
        uiTextField.text = nF.string(from: NSNumber(value: tfStr!))!
        
        return Int64((uiTextField.text?.replacingOccurrences(of: ",", with: ""))!)!
    }
}

class HTMLDataClass{
    
}
