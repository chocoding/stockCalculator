//
//  DeviceConfig.swift
//  StockCalculator
//
//  Created by 이정민 on 2021/03/27.
//

import UIKit
import SystemConfiguration

// 이 프로젝트에서는 사용하지 않음.
class DeviceManager{
    
    static let shared: DeviceManager = DeviceManager()
    
    var networkStatus: Bool{
        get{
            return checkDeviceNetworkStatus()
        }
    }
    
    private init(){
        
    }
    
    private func checkDeviceNetworkStatus() -> Bool {
            print("Check to Device Natwork Status....")
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            return ret
        }
}
