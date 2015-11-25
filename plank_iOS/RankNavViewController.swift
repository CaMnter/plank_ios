//
//  RankNavViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/24.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class RankNavViewController: RKSwipeBetweenViewControllers {
    
    var controllers:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPages()
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    func setupPages(){
        
        if controllers.count == 0 {
            let storyboard = UIStoryboard(name: "Challenge", bundle: nil)
            let todayRankController = storyboard.instantiateViewControllerWithIdentifier("rankPage") as! RankTableViewController
            todayRankController.rankType = RankTableViewController.RankType.today
            controllers.append(todayRankController)
            
            let weekRankController = storyboard.instantiateViewControllerWithIdentifier("rankPage") as! RankTableViewController
            
            todayRankController.rankType = RankTableViewController.RankType.week
            controllers.append(weekRankController)
        }
        self.viewControllerArray.addObjectsFromArray(controllers)
        self.buttonText = ["今日排行榜", "本周排行榜" ];
    }
}
