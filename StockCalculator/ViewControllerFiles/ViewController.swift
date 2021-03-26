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
    
    var exchange_Boolean = false
    var myCustomClass = MyCustomClass()
    
    // Test Code
    static var viewController: (UIColor) -> UIViewController = { (color) in
           let vc = UIViewController()
            vc.view.backgroundColor = color
            return vc
        }
    
//    var dataSource = [(menuTitle: "test1", vc: viewController(.red)), (menuTitle: "test2", vc: viewController(.blue)), (menuTitle: "test3", vc: viewController(.yellow))]
    
    var dataSource = [(menu: String, content: UIViewController)](){
        didSet{
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    lazy var firstLoad: (()-> Void)? = {[weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData()
        self?.firstLoad = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        checkDeviceNetworkStatus()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagingViewStart()
        adMobStart()
    }
    
//    func checkDeviceNetworkStatus() {
//            if(DeviceManager.shared.networkStatus) {
//                let firstVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
//                present(firstVC, animated: true, completion: nil)
//
//            } else {
//                let alert: UIAlertController = UIAlertController(title: "네트워크 상태 확인", message: "네트워크가 불안정 합니다.", preferredStyle: .alert)
//                let action: UIAlertAction = UIAlertAction(title: "다시 시도", style: .default, handler: { (ACTION) in
//                    self.checkDeviceNetworkStatus()
//                })
//                alert.addAction(action)
//                present(alert, animated: true, completion: nil)
//            }
//        }
}
