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
        
        let usersViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        let repositoriesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        let gistsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
        let organizationsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        
        let viewControllers = [usersViewController, repositoriesViewController, gistsViewController, organizationsViewController]
        
        let options = PagingMenuOptions()
        options.menuHeight = 50
        options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: false, scrollingMode: .ScrollEnabledAndBouces)
        
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