//
//  AppDelegate.swift
//  ADSideMenuSample
//
//  Created by duanhongjin on 16/6/17.
//  Copyright © 2016年 comisys. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let contentVC: ADContentViewController = ADContentViewController()
        let nav: UINavigationController = UINavigationController(rootViewController: contentVC)
        let leftVC: ADLeftMenuViewController = ADLeftMenuViewController()
        let rightVC: ADRightMenuViewController = ADRightMenuViewController()
        
        let sideMenu: ADSideMenuVC = ADSideMenuVC(contentVC: nav, leftMenuVC: leftVC, rightMenuVC: rightVC)
        sideMenu.backgroundImage = UIImage(named: "Stars")
        self.window?.rootViewController = sideMenu
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

