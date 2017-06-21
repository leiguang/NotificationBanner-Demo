//
//  ExampleTableViewCell.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/19.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

class ExampleTableViewCell: UITableViewCell {
    
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var coloredBlockView: UIImageView!
    
    var model: ExampleCellModel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        coloredBlockView = UIImageView()
        coloredBlockView.contentMode = .scaleAspectFit
        contentView.addSubview(coloredBlockView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20.0)
        contentView.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        subtitleLabel.textColor = .lightGray
        contentView.addSubview(subtitleLabel)
        
        coloredBlockView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(coloredBlockView.snp.height)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(titleLabel)
            make.bottom.equalTo(coloredBlockView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        guard let model = model else {
            return
        }
        
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        
        if let _ = model.subtitle {
            subtitleLabel.isHidden = false
            titleLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(coloredBlockView.snp.right).offset(15)
                make.right.equalToSuperview().offset(-15)
                make.top.equalTo(coloredBlockView)
            }
        } else {
            subtitleLabel.isHidden = true
            titleLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(coloredBlockView.snp.right).offset(15)
                make.right.equalToSuperview().offset(-15)
                make.centerY.equalTo(coloredBlockView)
            }
        }
        
        if let image = model.iconImage {
            coloredBlockView.image = image
            coloredBlockView.backgroundColor = .clear
        } else if let color = model.iconColor {
            coloredBlockView.image = nil 
            coloredBlockView.backgroundColor = color
        }
    }
}
