//
//  ViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/10/15.
//  Copyright (c) 2015 kitasuke. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.tabBarController?.delegate = self
        // FYI: http://stackoverflow.com/questions/31611756/uitabbarcontrollerdelegate-method-not-getting-called
        self.delegate = self

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if let nv = viewController as? UINavigationController{
            if let meController = nv.childViewControllers[0] as? Me_RootViewController {
                meController.isRoot = true
            }
        }
        return true
    }
    
}