//
//  LGBaseNotificationBanner.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/19.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

public class LGBaseNotificationBanner: UIView {

    var bannerHeight = 64.0
    var duration: TimeInterval = 1
    
    let appWindow = UIApplication.shared.delegate!.window!!
    let screenWidth = Double(UIApplication.shared.delegate!.window!!.frame.width)
    
    public private(set) var isSuspended = false
    public private(set) var isDisplaying = false
    
    private var spacerView: UIView!
    
    private weak var parentViewController: UIViewController?
    
    private var bannerQueue = LGNotificationBannerQueue.default
    
    public var autoDismiss = true
    
    public var onTap: (() -> Void)?
    public var onSwipeUp: (() -> Void)?
    public var dismissOnTap: Bool = true
    public var dismissOnSwipeUp: Bool = true
    
    public var haptic: LGBannerHaptic = .light
    
    public override var backgroundColor: UIColor? {
        willSet {
            spacerView.backgroundColor = newValue
        }
    }
    
    
    init(style: LGNotificationBannerStyle, colors: LGNotificationBannerColorsProtocol? = nil) {
        super.init(frame: .zero)
        
        spacerView = UIView()
        spacerView.backgroundColor = backgroundColor
        addSubview(spacerView)
        spacerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.snp.top)
            make.height.equalTo(10)
        }
       
        if let _ = colors {
            backgroundColor = colors!.color(style: style)
        } else {
            backgroundColor = LGNotificationBannerColors().color(style: style)
        }
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTapGestureRecognizer))
        addGestureRecognizer(tapGestureRecognizer)
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeUpGestureRecognizer))
        swipeUpGesture.direction = .up
        addGestureRecognizer(swipeUpGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(onOrientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func show(queuePosition: LGNotificationBannerQueuePosition, on viewController: UIViewController? = nil) {
        parentViewController = viewController
        show(placeOnQueue: true, queuePosition: queuePosition)
    }
    
    func show(placeOnQueue: Bool, queuePosition: LGNotificationBannerQueuePosition = .back) {
        
        if placeOnQueue {
            
            bannerQueue.addBanner(self, queuePosition: queuePosition)
            
        } else {
            
            self.frame = CGRect(x: 0.0, y: -bannerHeight, width: screenWidth, height: bannerHeight)
            
            if let parentViewController = parentViewController {
                parentViewController.view.addSubview(self)
                if statusBarShouldBeShown() {
                    appWindow.windowLevel = UIWindowLevelStatusBar + 1
                }
            } else {
                appWindow.addSubview(self)
                appWindow.windowLevel = UIWindowLevelStatusBar + 1
            }
            
            LGBannerHapticGenerator.generate(haptic)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveLinear, animations: {
                
                self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                
            }) { (completed) in
                
                self.isDisplaying = true
                
                if !self.isSuspended && self.autoDismiss {
                    self.perform(#selector(self.dismiss), with: nil, afterDelay: self.duration)
                }
                
            }
        }
    }
    
    func dismiss() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dismiss), object: nil)
        UIView.animate(withDuration: 1, animations: {
            self.frame = CGRect(x: 0, y: -self.frame.height, width: self.frame.width, height: self.frame.height)
        }) { (completed) in
            if completed {
                self.removeFromSuperview()
                self.isDisplaying = false
                self.bannerQueue.showNext(callback: { (isEmpty) in
                    if isEmpty || self.statusBarShouldBeShown() {
                        self.appWindow.windowLevel = UIWindowLevelNormal
                    }
                })
            }
        }
    }
    
    func suspend() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dismiss), object: nil)
        isSuspended = true
        isDisplaying = false
    }
    
    func resume() {
        if autoDismiss {
            self.perform(#selector(dismiss), with: nil, afterDelay: duration)
        }
        
        isSuspended = false
        isDisplaying = true
    }
    
    @objc private func onTapGestureRecognizer() {
        if dismissOnTap {
            dismiss()
        }
        
        onTap?()
    }
    
    @objc private func onSwipeUpGestureRecognizer() {
        if dismissOnSwipeUp {
            dismiss()
        }
        
        onSwipeUp?()
    }
    
    private func statusBarShouldBeShown() -> Bool {
        for banner in bannerQueue.banners {
            if banner.parentViewController == nil {
                return false
            }
        }
        return true
    }
    
    @objc private func onOrientationChanged() {
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: appWindow.frame.width, height: self.frame.height)
    }
}
