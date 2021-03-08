//
//  GoogleAdmob.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/08.
//

import UIKit
import GoogleMobileAds

extension ViewController
{
    func adMobStart()
    {
        // 배너의 사이즈를 조정
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        
        // 광고 배너의 아이디 설정
        bannerView.adUnitID = myID
        
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView)
    {
        // 오토레이아웃을 뷰를 설정
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        // 루트뷰에 배너를 추가
        view.addSubview(bannerView)
        
        // 앵커를 설정하여 오토레이아웃 설정
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
}
