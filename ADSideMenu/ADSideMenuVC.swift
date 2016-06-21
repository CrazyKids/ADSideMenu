//
//  ADSideMenuVC.swift
//  ADSideMenuSample
//
//  Created by duanhongjin on 16/6/17.
//  Copyright © 2016年 comisys. All rights reserved.
//

import UIKit

class ADSideMenuVC: UIViewController {

    var leftMenuVC: UIViewController?
    var rightMenuVC: UIViewController?
    var contentVC: UIViewController?
    
    var backgroundImage: UIImage?
    
    private var backgroundImageView: UIImageView = UIImageView()
    private var contentViewContainer: UIView = UIView()
    private var menuViewContainer: UIView = UIView()

    convenience init(contentVC: UIViewController, leftMenuVC: UIViewController?, rightMenuVC: UIViewController?) {
        self.init()
        
        self.leftMenuVC = leftMenuVC
        self.contentVC = contentVC
        self.rightMenuVC = rightMenuVC
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .ScaleAspectFill
        
        view.addSubview(backgroundImageView)
        view.addSubview(menuViewContainer)
        view.addSubview(contentViewContainer)
        
        contentViewContainer.frame = view.bounds
        menuViewContainer.frame = view.bounds
        contentViewContainer.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        menuViewContainer.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        if let leftVC = leftMenuVC {
            addChildViewController(leftVC)
            leftVC.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            menuViewContainer.addSubview(leftVC.view)
            leftVC.didMoveToParentViewController(self)
        }
        
        if let rightVC = rightMenuVC {
            addChildViewController(rightVC)
            rightVC.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            menuViewContainer.addSubview(rightVC.view)
            rightVC.didMoveToParentViewController(self)
        }
        
        addChildViewController(contentVC!)
        contentVC!.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        contentViewContainer.addSubview(contentVC!.view)
        contentVC!.didMoveToParentViewController(self)
    }

    
}
