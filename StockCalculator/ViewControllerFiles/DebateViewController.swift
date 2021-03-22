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
    
    // MARK: Function
    
    func openURL(_ url: String){
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Action Function
    
    @IBAction func koreaDebateAction(_ sender: Any) {
        if let text = debateTextfield.text{
            openURL(text)
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
