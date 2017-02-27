//
//  ADRightMenuViewController.swift
//  ADSideMenuSample
//
//  Created by duanhongjin on 16/6/17.
//  Copyright © 2016年 comisys. All rights reserved.
//

import UIKit

class ADRightMenuViewController: UIViewController, UITableViewDataSource {

    var tableView: UITableView?
    let tableData = ["小明", "小红", "小兰", "小邓"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds)
        tableView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView?.dataSource = self
//        tableView?.backgroundColor = UIColor.clearColor()
        tableView?.tableFooterView = UIView(frame: CGRect.zero)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.selectionStyle = .none
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.textAlignment = .right
        
        return cell
    }

}
