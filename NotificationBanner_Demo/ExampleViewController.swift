//
//  ExampleViewController.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/16.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    
    var exampleView: ExampleView!
    
    var selectedQueuePosition: LGNotificationBannerQueuePosition {
        get {
            let selectedIndex = exampleView.segmentedControl.selectedSegmentIndex
            return selectedIndex == 0 ? .front : .back
        }
    }
    
    override func loadView() {
        exampleView = ExampleView(delegate: self)
        view = exampleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notification Banner"
        edgesForExtendedLayout = UIRectEdge()
        
        exampleView.datas = ExampleModel.datas()
        exampleView.tableView.reloadData()
    }
}

extension ExampleViewController: ExampleViewDelegate {
    
    func exampleCellDidSelectedRow(at indexPath: IndexPath) {
        
        let sectionModel = exampleView.datas[indexPath.section].cells
        let cellModel = sectionModel[indexPath.row]
        let title = cellModel.title
        let subtitle = cellModel.subtitle
        
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                // Basic Success Notification
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, style: .success)
                banner.onTap     = { self.showAlert(title: title, message: "") }
                banner.onSwipeUp = { self.showAlert(title: title, message: "") }
                banner.show(queuePosition: selectedQueuePosition)
            case 1:
                // Basic Danger Notification
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, style: .danger)
                banner.onTap = { self.showAlert(title: title, message: "") }
                banner.show(queuePosition: selectedQueuePosition)
            case 2:
                //Basic Info Notification
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, style: .info)
                banner.onTap = { self.showAlert(title: title, message: "") }
                banner.show(queuePosition: selectedQueuePosition)
            case 3:
                // Basic Warning Notification
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, style: .warning)
                banner.onTap = { self.showAlert(title: "Banner Warning Notification Tapped", message: "") }
                banner.show(queuePosition: selectedQueuePosition)
            case 4:
                // Basic Warning Notification with Custom Color
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, style: .warning, colors: ExampleCustomColors())
                banner.onTap = { self.showAlert(title: title, message: "") }
                banner.show(queuePosition: selectedQueuePosition, on: self)
            case 5:
                // Basic Warning Notification with Custom Color
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, style: .none)
                banner.backgroundColor = .green
                banner.autoDismiss = false
                banner.onTap = {
                    self.showAlert(title: title, message: "")
                    banner.dismiss()
                }
                banner.onSwipeUp = {
                    banner.dismiss()
                }
                banner.show(queuePosition: selectedQueuePosition)
            default:
                return
            }
        case 1:
            switch indexPath.row {
            case 0:
                // Success Notification with Left View
                let leftView = UIImageView(image: #imageLiteral(resourceName: "success"))
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, leftView: leftView, style: .success)
                banner.show(queuePosition: selectedQueuePosition)
            case 1:
                // Danger Notification with Right View
                let rightView = UIImageView(image: #imageLiteral(resourceName: "danger"))
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, rightView: rightView, style: .danger)
                banner.show(queuePosition: selectedQueuePosition)
            case 2:
                // Info Notification with Left and Right Views
                let leftView = UIImageView(image: #imageLiteral(resourceName: "info"))
                let rightView = UIImageView(image: #imageLiteral(resourceName: "right_chevron"))
                let banner = LGNotificationBanner(title: title, subtitle: subtitle, leftView: leftView, rightView: rightView, style: .info)
                banner.show(queuePosition: selectedQueuePosition)
            default:
                return
            }
        case 2:
            switch indexPath.row {
            case 0:
                // Tarheels Completely Custom Notification
                let banner = LGNotificationBanner(customView: NorthCarolinaBannerView())
                banner.show(queuePosition: selectedQueuePosition)
            default:
                return
            }
        case 3:
            switch indexPath.row {
            case 0:
                // Status Bar Success Notification
                let banner = LGStatusBarNotificationBanner(title: title, style: .success)
                banner.show(queuePosition: selectedQueuePosition)
            case 1:
                // Status Bar Danger Notification
                let banner = LGStatusBarNotificationBanner(title: title, style: .danger)
                banner.show(queuePosition: selectedQueuePosition)
            case 2:
                // Status Bar Info Notification
                let banner = LGStatusBarNotificationBanner(title: title, style: .info)
                banner.show(queuePosition: selectedQueuePosition)
            case 3:
                // Status Bar Warning Notification
                let banner = LGStatusBarNotificationBanner(title: title, style: .warning)
                banner.show(queuePosition: selectedQueuePosition)
            case 4:
                // Status Bar Attributed Title Notification
                let title = "Custom Status Bar Notification"
                let attributedTitle = NSMutableAttributedString(string: title)
                attributedTitle.addAttribute(NSForegroundColorAttributeName,
                                             value: UIColor.red,
                                             range: (title as NSString).range(of: "Custom"))
                attributedTitle.addAttribute(NSForegroundColorAttributeName,
                                             value: UIColor.cyan,
                                             range: (title as NSString).range(of: "Status"))
                attributedTitle.addAttribute(NSForegroundColorAttributeName,
                                             value: UIColor.green,
                                             range: (title as NSString).range(of: "Bar"))
                attributedTitle.addAttribute(NSForegroundColorAttributeName,
                                             value: UIColor.orange,
                                             range: (title as NSString).range(of: "Notification"))
                let banner = LGStatusBarNotificationBanner(attributedTitle: attributedTitle)
                banner.backgroundColor = UIColor(red:0.54, green:0.40, blue:0.54, alpha:1.00)
                banner.show(queuePosition: selectedQueuePosition)
            default:
                return
            }

        default:
            return
        }
    }
    
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}
