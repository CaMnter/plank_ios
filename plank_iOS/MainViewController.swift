//
//  ViewController.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 5/10/15.
//  Copyright (c) 2015 kitasuke. All rights reserved.
//

import UIKit
import PagingMenuController

class MainViewController: UIViewController, PagingMenuControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let trainViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        trainViewController.title = "训练"
        let challengeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        challengeViewController.title = "挑战"
        let recordViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
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
}