//
//  ExampleView.swift
//  NotificationBanner_Demo
//
//  Created by 雷广 on 2017/6/16.
//  Copyright © 2017年 leiguang. All rights reserved.
//

import UIKit

protocol ExampleViewDelegate: class {
    func exampleCellDidSelectedRow(at indexPath: IndexPath)
}

class ExampleView: UIView {

    weak var delegate: ExampleViewDelegate!
    var segmentedControl: UISegmentedControl!
    private(set) var tableView: UITableView!
    let reuseIdentifier = "BasicNotificationBannerCell"
    
    var datas: [ExampleSectionModel] = []
    
    
    init(delegate: ExampleViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        
        let segmentLabel = UILabel()
        segmentLabel.font = UIFont.systemFont(ofSize: 12)
        segmentLabel.text = "Queue Position:"
        addSubview(segmentLabel)
        
        segmentedControl = UISegmentedControl(items: ["Front", "Back"])
        segmentedControl.selectedSegmentIndex = 1
        addSubview(segmentedControl)
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = 75.0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExampleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        addSubview(tableView)
        
        
        // Make Constraints
        segmentLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(segmentLabel.snp.bottom).offset(4)
            make.width.equalTo(150)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        backgroundColor = tableView.backgroundColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ExampleView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return datas[section].headerTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let exampleCell = cell as? ExampleTableViewCell {
            let sectionModel = datas[indexPath.section].cells
            let cellModel = sectionModel[indexPath.row]
            exampleCell.model = cellModel
        }
        return cell
    }
}

extension ExampleView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let exampleCell = cell as? ExampleTableViewCell {
            exampleCell.update()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate.exampleCellDidSelectedRow(at: indexPath)
    }
}

