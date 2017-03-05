//
//  ADContentViewController.swift
//  ADSideMenuSample
//
//  Created by duanhongjin on 16/6/17.
//  Copyright © 2016年 comisys. All rights reserved.
//

import UIKit

class ADContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Content ViewController"
        view.backgroundColor = UIColor.green
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(ADContentViewController.onLeftBarButtonClicked(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .plain, target: self, action: #selector(ADContentViewController.onRightBarButtonClicked(_:)))
    }
    
    func onLeftBarButtonClicked(_ anyObject: AnyObject) {
        if let sideMenu = self.sideMenuViewControoler() {
            sideMenu.presentLeftMenuViewController()
        }
    }
    
    func onRightBarButtonClicked(_ anyObject: AnyObject) {
        if let sideMenu = self.sideMenuViewControoler() {
            sideMenu.presentRightMenuViewController()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
