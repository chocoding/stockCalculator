//
//  ViewController.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/08.
//

import UIKit
import GoogleMobileAds
import PagingKit

class ViewController: UIViewController {
    
    var bannerView: GADBannerView!
    let myID = "ca-app-pub-5353181976991649/5204964682"
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    // Test Code
    static var viewController: (UIColor) -> UIViewController = { (color) in
           let vc = UIViewController()
            vc.view.backgroundColor = color
            return vc
        }
    
    var dataSource = [(menuTitle: "test1", vc: viewController(.red)), (menuTitle: "test2", vc: viewController(.blue)), (menuTitle: "test3", vc: viewController(.yellow))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagingViewStart()
        adMobStart()
    }
}
