//
//  ADSideMenuVC.swift
//  ADSideMenuSample
//
//  Created by duanhongjin on 16/6/17.
//  Copyright © 2016年 comisys. All rights reserved.
//

import UIKit

public class ADSideMenuVC: UIViewController {

    public var leftMenuVC: UIViewController?
    public var rightMenuVC: UIViewController?
    public var contentVC: UIViewController?
    
    public var scaleContentView: Bool = true
    public var scaleMenuView: Bool = true
    public var menuViewControllerTransformation: CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    public var animationDuration: TimeInterval = 0.35
    public var contentViewScaleValue: CGFloat = 0.7
    
    var contentViewContainer: UIView = UIView()
    var menuViewContainer: UIView = UIView()
    var contentButton: UIButton = UIButton()
    var leftMenuVisible: Bool = false
    var rightMenuVisible: Bool = false

    convenience public init(contentVC: UIViewController, leftMenuVC: UIViewController?, rightMenuVC: UIViewController?) {
        self.init()
        
        self.leftMenuVC = leftMenuVC
        self.contentVC = contentVC
        self.rightMenuVC = rightMenuVC
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor.white
        
        view.addSubview(menuViewContainer)
        view.addSubview(contentViewContainer)
        
        contentViewContainer.frame = view.bounds
        menuViewContainer.frame = view.bounds
        contentViewContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        menuViewContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let leftVC = self.leftMenuVC {
            addChildViewController(leftVC)
            leftVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            menuViewContainer.addSubview(leftVC.view)
            leftVC.didMove(toParentViewController: self)
        }
        
        if let rightVC = self.rightMenuVC {
            addChildViewController(rightVC)
            rightVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            menuViewContainer.addSubview(rightVC.view)
            rightVC.didMove(toParentViewController: self)
        }
        
        addChildViewController(contentVC!)
        contentVC!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentViewContainer.addSubview(contentVC!.view)
        contentVC!.didMove(toParentViewController: self)
        
        contentButton.frame = CGRect.null
        contentButton .addTarget(self, action:#selector(hiddenMenuViewController), for: .touchUpInside)
    }
    
    public func presentLeftMenuViewController() {
        if let leftMenu = self.leftMenuVC {
            presentMenuViewController(leftMenu)
            showLeftMenuViewController()
        }
    }
    
    public func presentRightMenuViewController() {
        if let rightMenu = self.rightMenuVC {
            presentMenuViewController(rightMenu)
            showRightMenuViewController()
        }
    }
    
    public func hiddenMenuViewController() {
        hiddenMenuVC(true)
    }
    
    func presentMenuViewController(_ menuVC: UIViewController) {
        menuViewContainer.transform = CGAffineTransform.identity
        menuViewContainer.frame = view.bounds
        if scaleMenuView {
            menuViewContainer.transform = menuViewControllerTransformation
        }
    }
    
    func showLeftMenuViewController() {
        if self.leftMenuVC == nil {
            return
        }
        
        self.leftMenuVC?.beginAppearanceTransition(true, animated: true)
        self.leftMenuVC?.view.isHidden = false
        self.rightMenuVC?.view.isHidden = true
        
        view.window?.endEditing(false)
        addContentButton()
        resetContentViewScale()
        
        UIView.animate(withDuration: animationDuration, animations: {
            if self.scaleContentView {
                self.contentViewContainer.transform = CGAffineTransform(scaleX: self.contentViewScaleValue, y: self.contentViewScaleValue)
            } else {
                self.contentViewContainer.transform = CGAffineTransform.identity
            }
            
            self.contentViewContainer.center = CGPoint(x: self.view.bounds.width + 30, y: self.contentViewContainer.center.y)
            self.contentViewContainer.alpha = 1
            self.menuViewContainer.transform = CGAffineTransform.identity
        }) { (finished: Bool) in
            self.leftMenuVC?.endAppearanceTransition()
            self.leftMenuVisible = true
        }
    }
    
    func showRightMenuViewController() {
        if rightMenuVC == nil {
            return
        }
        
        rightMenuVC?.beginAppearanceTransition(true, animated: true)
        rightMenuVC?.view.isHidden = true
        rightMenuVC?.view.isHidden = false
        
        view.window?.endEditing(false)
        addContentButton()
        resetContentViewScale()
        
        UIView.animate(withDuration: animationDuration, animations: {
            if self.scaleContentView {
                self.contentViewContainer.transform = CGAffineTransform(scaleX: self.contentViewScaleValue, y: self.contentViewScaleValue)
            } else {
                self.contentViewContainer.transform = CGAffineTransform.identity
            }
            
            self.contentViewContainer.center = CGPoint(x: -30, y: self.contentViewContainer.center.y)
            self.contentViewContainer.alpha = 1
            self.menuViewContainer.transform = CGAffineTransform.identity
        }) { (finished: Bool) in
            self.rightMenuVC?.endAppearanceTransition()
            self.rightMenuVisible = true
        }
    }
    
    func resetContentViewScale() {
        let t: CGAffineTransform = contentViewContainer.transform
        let scale: CGFloat = sqrt(t.a * t.a + t.c * t.c)
        let frame: CGRect = contentViewContainer.frame
        contentViewContainer.transform = CGAffineTransform.identity
        contentViewContainer.transform = CGAffineTransform(scaleX: scale, y: scale)
        contentViewContainer.frame = frame
    }
    
    func addContentButton() {
        if contentButton.superview != nil {
            return
        }

        contentButton.frame = contentViewContainer.bounds
        contentButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentViewContainer.addSubview(contentButton)
    }
    
    func hiddenMenuVC(_ animated: Bool) {
        let menuVC: UIViewController? = rightMenuVisible ? rightMenuVC : leftMenuVC
        if menuVC == nil {
            return
        }
        
        menuVC?.beginAppearanceTransition(false, animated: animated)
        rightMenuVisible = false
        leftMenuVisible = false
        contentButton.removeFromSuperview()
        
        if animated {
            UIApplication.shared.beginIgnoringInteractionEvents()
            UIView.animate(withDuration: animationDuration, animations: {
                self.animationBlock()
            }, completion: { (finised: Bool) in
                UIApplication.shared.endIgnoringInteractionEvents()
                menuVC!.endAppearanceTransition()
            })
        } else {
            self.animationBlock()
            menuVC!.endAppearanceTransition()
        }
    }
    
    func animationBlock() {
        contentViewContainer.transform = CGAffineTransform.identity
        contentViewContainer.frame = view.bounds
        if (scaleMenuView) {
            menuViewContainer.transform = menuViewControllerTransformation
        }
        contentViewContainer.alpha = 1
    }
}
