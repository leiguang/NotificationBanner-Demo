//
//  LGNotificationBanner.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/20.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

public class LGNotificationBanner: LGBaseNotificationBanner {
    
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    private var leftView: UIView?
    private var rightView: UIView?
    
    private let padding: Double = 15.0
    
    public init(title: String? = nil,
                subtitle: String? = nil,
                leftView: UIView? = nil,
                rightView: UIView? = nil,
                style: LGNotificationBannerStyle = .info,
                colors: LGNotificationBannerColorsProtocol? = nil) {
        
        super.init(style: style, colors: colors)
        
        if let leftView = leftView {
            addSubview(leftView)
            leftView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.left.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
                make.width.equalTo(leftView.snp.height)
            }
        }
        
        if let rightView = rightView {
            addSubview(rightView)
            rightView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.bottom.equalToSuperview().offset(-10)
                make.width.equalTo(rightView.snp.height)
            }
        }
        
        let labelsView = UIView()
        addSubview(labelsView)
        
        titleLabel = UILabel()
        titleLabel!.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
        titleLabel!.textColor = .white
        titleLabel!.text = title
        labelsView.addSubview(titleLabel!)
        
        titleLabel!.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            if let _ = subtitle {
                titleLabel!.numberOfLines = 1
            } else {
                titleLabel!.numberOfLines = 2
            }
        }
        
        if let subtitle = subtitle {
            subtitleLabel = UILabel()
            subtitleLabel!.font = UIFont.systemFont(ofSize: 15.0)
            subtitleLabel!.textColor = .white
            subtitleLabel!.text = subtitle
            labelsView.addSubview(subtitleLabel!)
            
            subtitleLabel!.snp.makeConstraints({ (make) in
                make.top.equalTo(titleLabel!.snp.bottom).offset(3)
                make.left.right.equalTo(titleLabel!)
            })
        }
        
        labelsView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            
            if let leftView = leftView {
                make.left.equalTo(leftView.snp.right).offset(padding)
            } else {
                make.left.equalToSuperview().offset(padding)
            }
            
            if let rightView = rightView {
                make.right.equalTo(rightView.snp.left).offset(-padding)
            } else {
                make.right.equalToSuperview().offset(-padding)
            }
            
            if let subtitleLabel = subtitleLabel {
                make.bottom.equalTo(subtitleLabel)
            } else {
                make.bottom.equalTo(titleLabel!)
            }
        }
    }
    public convenience init(attributedTitle: NSAttributedString,
                            attributedSubtitle: NSAttributedString? = nil,
                            leftView: UIView? = nil,
                            rightView: UIView? = nil,
                            style: LGNotificationBannerStyle = .info,
                            colors: LGNotificationBannerColorsProtocol? = nil) {
        
        let subtitle = (attributedSubtitle != nil) ? "" : nil
        self.init(title: "", subtitle: subtitle, leftView: leftView, rightView: rightView, style: style, colors: colors)
        titleLabel!.attributedText = attributedTitle
        subtitleLabel?.attributedText = attributedSubtitle
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(customView: UIView) {
        super.init(style: .none)
        addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
