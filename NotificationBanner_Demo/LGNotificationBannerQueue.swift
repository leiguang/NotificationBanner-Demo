//
//  LGNotificationBannerQueue.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/21.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import Foundation

public enum LGNotificationBannerQueuePosition {
    case back
    case front
}

public class LGNotificationBannerQueue {
    
    public static let `default` = LGNotificationBannerQueue()
    private(set) var banners: [LGBaseNotificationBanner] = []
    
    private init() {}   // 必须保证init方法的私有性，只有这样，才能保证单例是真正唯一的，避免外部对象通过访问init方法创建单例类的其他实例。
    
    func addBanner(_ banner: LGBaseNotificationBanner, queuePosition: LGNotificationBannerQueuePosition) {
        
        if queuePosition == .back {
            banners.append(banner)
            
            if banners.index(of: banner) == 0 {
                banner.show(placeOnQueue: false)
            }
            
        } else {
            banner.show(placeOnQueue: false)
            
            if let firstBanner = banners.first {
                firstBanner.suspend()
            }
            
            banners.insert(banner, at: 0)
        }
    }
    
    func showNext(callback: ((_ isEmpty: Bool) -> Void)) {
        if !banners.isEmpty {
            banners.removeFirst()
        }
        
        guard let banner = banners.first else {
            callback(true)
            return
        }
        
        if banner.isSuspended {
            banner.resume()
        } else {
            banner.show(placeOnQueue: false)
        }
        callback(false)
    }
}








