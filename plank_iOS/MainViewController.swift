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
    
    var viewControllers:[UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let trainViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        trainViewController.title = "训练"
        let challengeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TrainViewController") as! TrainViewController
        challengeViewController.title = "挑战"
        let recordViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RecordViewController") as! RecordViewController
        recordViewController.title = "记录"
        
        self.viewControllers = [trainViewController, challengeViewController, recordViewController]
        
        let options = PagingMenuOptions()
        options.menuHeight = 50
        //options.menuDisplayMode = .Standard(widthMode: .Flexible, centerItem: true, scrollingMode: .ScrollEnabledAndBouces)
        options.menuDisplayMode = .SegmentedControl
        
        let pagingMenuController = self.childViewControllers.first as! PagingMenuController
        pagingMenuController.delegate = self
        pagingMenuController.setup(viewControllers: viewControllers, options: options)
        
        //DBHelper.sharedInstance.queryData("train", date: NSDate(), delegate: self)
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
extension MainViewController: LoadDataProtocol {
    func didDataLoadFinish(table: String, date: NSDate, result: Dictionary<String, Int64>) {
        // TODO
        let recordViewController:RecordViewController = viewControllers[2] as! RecordViewController
        recordViewController.trainData[date] = result
        recordViewController.currentDate = date
        
    }
}