//
//  BannerHapticGenerator.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/21.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

public enum LGBannerHaptic {
    case light
    case medium
    case heavy
    case none
}

open class LGBannerHapticGenerator {
    
    open class func generate(_ haptic: LGBannerHaptic) {
        
        var style: UIImpactFeedbackStyle!
        
        switch haptic {
        case .light:
            style = .light
        case .medium:
            style = .medium
        case .heavy:
            style = .heavy
        case .none:
            return
        }
        
        if #available(iOS 10.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
            feedbackGenerator.prepare()
            feedbackGenerator.impactOccurred()
        }
    }
}
