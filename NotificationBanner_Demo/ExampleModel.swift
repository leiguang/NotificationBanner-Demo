//
//  ExampleModel.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/16.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import Foundation
import UIKit

struct ExampleModel {
    
    static func datas() -> [ExampleSectionModel] {
        return [
            ExampleSectionModel(headerTitle: "BASIC NOTIFICATION BANNERS", cells: [
                ExampleCellModel("Basic Success Notification", nil, .success),
                ExampleCellModel("Basic Danger Notification", nil, .danger),
                ExampleCellModel("Basic Info Notification", nil, .info),
                ExampleCellModel("Basic Warning Notification", nil, .warning),
                ExampleCellModel("Custom Warning Notification", "Displayed Under the Navigation Bar", .warning),
                ExampleCellModel("Basic Notification", "Must Be Dismissed Manually", .warning),
                ]),
            ExampleSectionModel(headerTitle: "NOTIFICATION BANNERS WITH SIDE VIEWS", cells: [
                ExampleCellModel("Success Notification", "With Left View", .success),
                ExampleCellModel("Danger Notification", "With Right View", .danger),
                ExampleCellModel("Info Notification", "With Left and Right Views", .info),
                ]),
            ExampleSectionModel(headerTitle: "NOTIFICATION BANNER WITH CUSTOM VIEW", cells: [
                ExampleCellModel("Tarheels Notification", "Completely Custom", .none, #imageLiteral(resourceName: "unc_logo")),
                ]),
            ExampleSectionModel(headerTitle: "STATUS BAR NOTIFICATIONS", cells: [
                ExampleCellModel("Success Notification", nil, .success),
                ExampleCellModel("Danger Notification", nil, .danger),
                ExampleCellModel("Info Notification", nil, .info),
                ExampleCellModel("Warning Notification", nil, .warning),
                ExampleCellModel("Custom Notification", nil, .warning),
                ])
        ]
    }
}

struct ExampleSectionModel {
    let headerTitle: String
    let cells: [ExampleCellModel]
}

struct ExampleCellModel {
    
    let title: String
    let subtitle: String?
    let iconColor: UIColor?
    let iconImage: UIImage?
    
    init(_ title: String, _ subtitle: String?, _ iconColorStyle: LGNotificationBannerStyle, _ iconImage: UIImage? = nil) {
        
        self.title = title
        self.subtitle = subtitle
        if iconColorStyle == .none {
            self.iconColor = nil
        } else {
            self.iconColor = ExampleCustomColors().color(style: iconColorStyle)
        }
        self.iconImage = iconImage
    }
}
