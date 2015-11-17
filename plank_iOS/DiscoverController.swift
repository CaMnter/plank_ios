//
//  DiscoverController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/14.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class DiscoverController: UITableViewController {
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // TODO set the title
        // TODO
        switch segue.identifier! {
        case "showFitnessPlus":
            let webViewController = segue.destinationViewController as! WebViewController
            webViewController.url = "http://mp.diaoba.wang/api/wx/daily_post_list?category_id=-1" // all post
            break
        case "showContributor":
            let postWebViewController = segue.destinationViewController as! PostWebViewController
            postWebViewController.postID = 207;
            postWebViewController.defaultTitle = "贡献者"
            break
        case "showTweet":
            segue.destinationViewController.title = "冒泡"
            let nav_tweet = segue.destinationViewController as! RKSwipeBetweenViewControllers
            setupMaopao(nav_tweet)
            break
        default:
            break
            
        }
    }
    
    func setupMaopao(nav_tweet:RKSwipeBetweenViewControllers){
//        let nav_tweet = RKSwipeBetweenViewControllers.newSwipeBetweenViewControllers();
        nav_tweet.viewControllerArray.addObjectsFromArray([Tweet_RootViewController.newTweetVCWithType(Tweet_RootViewControllerType.All),
            Tweet_RootViewController.newTweetVCWithType(Tweet_RootViewControllerType.Friend),
            Tweet_RootViewController.newTweetVCWithType(Tweet_RootViewControllerType.Hot)
            ])
        //[nav_tweet.viewControllerArray addObjectsFromArray:@[[Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeAll],
        //[Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeFriend],
        //[Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeHot]]];
        nav_tweet.buttonText = ["冒泡广场", "朋友圈", "热门冒泡"];
    }
    
}
