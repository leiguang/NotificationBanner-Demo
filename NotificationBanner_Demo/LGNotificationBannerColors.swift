//
//  NotificationBannerColors.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/16.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

public protocol LGNotificationBannerColorsProtocol {
    func color(style: LGNotificationBannerStyle) -> UIColor
}

public class LGNotificationBannerColors: LGNotificationBannerColorsProtocol {
    
    public func color(style: LGNotificationBannerStyle) -> UIColor {
        switch style {
            case .danger:   return UIColor(red:0.90, green:0.31, blue:0.26, alpha:1.00)
            case .info:     return UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00)
            case .none:     return UIColor.clear
            case .success:  return UIColor(red:0.22, green:0.80, blue:0.46, alpha:1.00)
            case .warning:  return UIColor(red:1.00, green:0.66, blue:0.16, alpha:1.00)
        }
    }
}
