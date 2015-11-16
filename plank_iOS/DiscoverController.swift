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
        segue.destinationViewController.title = "hello wolrd"
        // TODO
        switch segue.identifier! {
        case "showFitnessPlus":
            break
        case "showContributor":
            break
        case "showTweet":
            let tweetController = Tweet_RootViewController.newTweetVCWithType(Tweet_RootViewControllerType.All)
            //presentViewController(tweetController, animated: true, completion: nil)
            //segue.destinationViewController = tweetController
            break
        default:
            break
            
        }
    }
    
}
