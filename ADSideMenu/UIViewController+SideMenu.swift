//
//  UIViewController+SideMenu.swift
//  ADSideMenuSample
//
//  Created by duanhongjin on 6/22/16.
//  Copyright © 2016 comisys. All rights reserved.
//

import UIKit

public extension UIViewController {
    public func sideMenuViewControoler() -> ADSideMenuVC? {
        var iter: UIViewController? = self.parent
        while iter != nil {
            if (iter!.isKind(of: ADSideMenuVC.self)) {
                return iter as? ADSideMenuVC
            }
            
            iter = iter?.parent
        }
        
        return nil
    }
}
