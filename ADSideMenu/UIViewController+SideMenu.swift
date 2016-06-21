//
//  UIViewController+SideMenu.swift
//  ADSideMenuSample
//
//  Created by duanhongjin on 6/22/16.
//  Copyright © 2016 comisys. All rights reserved.
//

import UIKit

extension UIViewController {
    func sideMenuViewControoler() -> ADSideMenuVC? {
        var iter: UIViewController? = self.parentViewController
        while iter != nil {
            if (iter!.isKindOfClass(ADSideMenuVC)) {
                return iter as? ADSideMenuVC
            }
            
            iter = iter?.parentViewController
        }
        
        return nil
    }
}
