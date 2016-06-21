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
    
    var scaleContentView: Bool = true
    var scaleMenuView: Bool = true
    var menuViewControllerTransformation: CGAffineTransform = CGAffineTransformMakeScale(1.5, 1.5)
    var animationDuration: NSTimeInterval = 0.35
    var contentViewScaleValue: CGFloat = 0.7
    
    private var contentViewContainer: UIView = UIView()
    private var menuViewContainer: UIView = UIView()
    private var contentButton: UIButton = UIButton()
    private var leftMenuVisible: Bool = false
    private var rightMenuVisible: Bool = false

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
        view.backgroundColor = UIColor.whiteColor()
        
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
        
        contentButton.frame = CGRect.null
        contentButton .addTarget(self, action:#selector(hiddenMenuViewController), forControlEvents: .TouchUpInside)
    }
    
    private func presentMenuViewController(menuVC: UIViewController) {
        menuViewContainer.transform = CGAffineTransformIdentity
        menuViewContainer.frame = view.bounds
        if scaleMenuView {
            menuViewContainer.transform = menuViewControllerTransformation
        }
    }
    
    private func showLeftMenuViewController() {
        if leftMenuVC == nil {
            return
        }
        
        leftMenuVC?.beginAppearanceTransition(true, animated: true)
        leftMenuVC?.view.hidden = false
        rightMenuVC?.view.hidden = true
        
        view.window?.endEditing(false)
        addContentButton()
        resetContentViewScale()
        
        UIView.animateWithDuration(animationDuration, animations: {
            if self.scaleContentView {
                self.contentViewContainer.transform = CGAffineTransformMakeScale(self.contentViewScaleValue, self.contentViewScaleValue)
            } else {
                self.contentViewContainer.transform = CGAffineTransformIdentity
            }
            
            self.contentViewContainer.center = CGPointMake(self.view.bounds.width + 30, self.contentViewContainer.center.y)
            self.contentViewContainer.alpha = 1;
            self.menuViewContainer.transform = CGAffineTransformIdentity;
        }) { (finished: Bool) in
            self.leftMenuVC?.endAppearanceTransition()
            self.leftMenuVisible = true
        }
    }
    
    private func showRightMenuViewController() {
        if rightMenuVC == nil {
            return
        }
        
        rightMenuVC?.beginAppearanceTransition(true, animated: true)
        rightMenuVC?.view.hidden = true
        rightMenuVC?.view.hidden = false
        
        view.window?.endEditing(false)
        addContentButton()
        resetContentViewScale()
        
        UIView.animateWithDuration(animationDuration, animations: {
            if self.scaleContentView {
                self.contentViewContainer.transform = CGAffineTransformMakeScale(self.contentViewScaleValue, self.contentViewScaleValue)
            } else {
                self.contentViewContainer.transform = CGAffineTransformIdentity
            }
            
            self.contentViewContainer.center = CGPointMake(-30, self.contentViewContainer.center.y)
            self.contentViewContainer.alpha = 1;
            self.menuViewContainer.transform = CGAffineTransformIdentity;
        }) { (finished: Bool) in
            self.rightMenuVC?.endAppearanceTransition()
            self.rightMenuVisible = true
        }
    }
    
    private func resetContentViewScale() {
        let t: CGAffineTransform = contentViewContainer.transform
        let scale: CGFloat = sqrt(t.a * t.a + t.c * t.c)
        let frame: CGRect = contentViewContainer.frame
        contentViewContainer.transform = CGAffineTransformIdentity
        contentViewContainer.transform = CGAffineTransformMakeScale(scale, scale)
        contentViewContainer.frame = frame
    }
    
    private func addContentButton() {
        if contentButton.superview != nil {
            return
        }
        
        contentButton.autoresizingMask = .None
        contentButton.frame = contentViewContainer.bounds
        contentButton.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        contentViewContainer.addSubview(contentButton)
    }
    
    private func hiddenMenuVC(animated: Bool) {
        let menuVC: UIViewController? = rightMenuVisible ? rightMenuVC : leftMenuVC
        if menuVC == nil {
            return
        }
        
        menuVC?.beginAppearanceTransition(false, animated: animated)
        rightMenuVisible = false
        leftMenuVisible = false
        contentButton.removeFromSuperview()
        
        if animated {
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            UIView.animateWithDuration(animationDuration, animations: {
                self.animationBlock()
            }, completion: { (finised: Bool) in
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                menuVC!.endAppearanceTransition()
            })
        } else {
            self.animationBlock()
            menuVC!.endAppearanceTransition()
        }
    }
    
    private func animationBlock() {
        contentViewContainer.transform = CGAffineTransformIdentity;
        contentViewContainer.frame = view.bounds;
        if (scaleMenuView) {
            menuViewContainer.transform = menuViewControllerTransformation;
        }
        contentViewContainer.alpha = 1;
    }
}

extension ADSideMenuVC {
    func presentLeftMenuViewController() {
        if let leftMenu = self.leftMenuVC {
            presentMenuViewController(leftMenu)
            showLeftMenuViewController()
        }
    }
    
    func presentRightMenuViewController() {
        if let rightMenu = self.rightMenuVC {
            presentMenuViewController(rightMenu)
            showRightMenuViewController()
        }
    }
    
    func hiddenMenuViewController() {
        hiddenMenuVC(true)
    }
}

extension ADSideMenuVC {
    override func shouldAutorotate() -> Bool {
        return true;
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
}




