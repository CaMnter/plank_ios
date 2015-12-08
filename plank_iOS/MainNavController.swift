//
//  MainNavController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/19.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class MainNavController: RKSwipeBetweenViewControllers {
    
   var controllers:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        self.tabBarItem.title = "首页"
    }
    
    
    func setupPages(){
        
        if controllers.count == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let trainViewController = storyboard.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
            controllers.append(trainViewController)
            
            let challengeViewController = storyboard.instantiateViewControllerWithIdentifier("ChallengeViewController") as! ChallengeViewController
            controllers.append(challengeViewController)
            
            let recordViewController = storyboard.instantiateViewControllerWithIdentifier("RecordViewController") as! RecordViewController
            controllers.append(recordViewController)
            
        }
        self.viewControllerArray.addObjectsFromArray(controllers)
        self.buttonText = ["训练", "挑战", "记录"];
    }
    
}
