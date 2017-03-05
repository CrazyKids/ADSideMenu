//
//  ADNavigationController.swift
//  ADSideMenuSample
//
//  Created by duanhongjin on 2017/3/5.
//  Copyright © 2017年 comisys. All rights reserved.
//

import UIKit

class ADNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return (self.topViewController?.preferredStatusBarStyle)!
    }
}
