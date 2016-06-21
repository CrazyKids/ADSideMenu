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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: #selector(ADContentViewController.onLeftBarButtonClicked(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .Plain, target: self, action: #selector(ADContentViewController.onRightBarButtonClicked(_:)))
        
        let imageView: UIImageView = UIImageView(image: UIImage(named: "Balloon"))
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        imageView.contentMode = .ScaleAspectFill
        view.addSubview(imageView)
    }
    
    func onLeftBarButtonClicked(anyObject: AnyObject) {
        
    }
    
    func onRightBarButtonClicked(anyObject: AnyObject) {
        
    }

}
