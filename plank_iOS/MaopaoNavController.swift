//
//  MaopaoNavController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/19.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class MaopaoNavController: RKSwipeBetweenViewControllers {
    var controllers:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
    }
    
    
    func setupPages(){
        
        if controllers.count == 0 {
            let allController = Tweet_RootViewController.newTweetVCWithType(Tweet_RootViewControllerType.All)
            controllers.append(allController)
            
            let friendController = Tweet_RootViewController.newTweetVCWithType(Tweet_RootViewControllerType.Friend)
            controllers.append(friendController)
            
            let hotController = Tweet_RootViewController.newTweetVCWithType(Tweet_RootViewControllerType.Hot)
            controllers.append(hotController)
            
        }
        self.viewControllerArray.addObjectsFromArray(controllers)
        self.buttonText = ["冒泡广场", "朋友圈", "热门冒泡"];
    }

}
