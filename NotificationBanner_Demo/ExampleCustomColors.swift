//
//  ExampleCustomColors.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/19.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

class ExampleCustomColors: LGNotificationBannerColors {
    override func color(style: LGNotificationBannerStyle) -> UIColor {
        switch style {
        case .danger:   return super.color(style: style)
        case .info:     return super.color(style: style)
        case .none:     return super.color(style: style)
        case .success:  return super.color(style: style)
        case .warning:  return UIColor(red:0.99, green:0.40, blue:0.13, alpha:1.00)
        }
    }
}
