//
//  AppDelegate.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/8.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

@objc
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appDelegate_coding: AppDelegate_coding?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        appDelegate_coding = AppDelegate_coding()
        self.window?.makeKeyAndVisible()
        appDelegate_coding!.application(application, didFinishLaunchingWithOptions: launchOptions, window: self.window!);
        
        //Sync.shareInstance.syncTrainAndChallengeData()
        Sync.shareInstance.async()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disble timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func setupIntroductionViewController() -> Void{
        appDelegate_coding!.setupIntroductionViewController()
    }
    
    // called when user login
    func setupTabViewController() -> Void{
        
        Sync.shareInstance.async()
        appDelegate_coding!.setupTabViewController()
        
    }
    
    func setupLoginViewController() ->Void {
        appDelegate_coding!.setupLoginViewController()
        
    }
    
    
    // TODO
    //#pragma mark XGPush
    func registerPush() -> Void {
        appDelegate_coding!.registerPush()
    }
    
    func syncTrainAndChallengeData() ->Void {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                // TODO query db and sync
            })
        
    }
    
    
    
}

