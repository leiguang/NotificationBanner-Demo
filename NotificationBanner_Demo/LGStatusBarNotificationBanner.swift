//
//  LGStatusBarNotificationBanner.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/21.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

public class LGStatusBarNotificationBanner: LGBaseNotificationBanner {
    
    private var titleLabel: UILabel!
    
    override init(style: LGNotificationBannerStyle, colors: LGNotificationBannerColorsProtocol? = nil) {
        super.init(style: style, colors: colors)
        bannerHeight = 20.0
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightBold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
        }
        
    }
    
    public convenience init(title: String, style: LGNotificationBannerStyle = .info, colors: LGNotificationBannerColorsProtocol? = nil) {
        self.init(style: style, colors: colors)
        titleLabel.text = title
    }
    
    public convenience init(attributedTitle: NSAttributedString, style: LGNotificationBannerStyle = .info, colors: LGNotificationBannerColorsProtocol? = nil) {
        self.init(style: style, colors: colors)
        titleLabel.attributedText = attributedTitle
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
