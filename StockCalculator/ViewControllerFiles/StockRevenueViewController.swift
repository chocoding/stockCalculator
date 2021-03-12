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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
