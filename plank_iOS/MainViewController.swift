//
//  ViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/10/15.
//  Copyright (c) 2015 kitasuke. All rights reserved.
//

import UIKit
import PagingMenuController

class MainViewController: UIViewController, PagingMenuControllerDelegate, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tabBarController?.delegate = self
        let trainViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        trainViewController.title = "训练"
        let challengeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        challengeViewController.title = "挑战"
        let recordViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RecordViewController") as! RecordViewController
        recordViewController.title = "记录"
        
        let viewControllers = [trainViewController, challengeViewController, recordViewController]
        
        let options = PagingMenuOptions()
        options.menuHeight = 50
        //options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: true, scrollingMode: .ScrollEnabledAndBouces)
        options.menuDisplayMode = .SegmentedControl
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PagingMenuControllerDelegate
    
    func willMoveToMenuPage(page: Int) {
    }
    
    func didMoveToMenuPage(page: Int) {
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if let viewController = viewController as? RKSwipeBetweenViewControllers {
            setupMaopao(viewController)
        }else if let nv = viewController as? UINavigationController{
            if let meController = nv.childViewControllers[0] as? Me_RootViewController {
                meController.isRoot = true
            }
        }
        return true
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