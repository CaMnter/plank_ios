//
//  FirstViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/8.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit
import Alamofire

class TrainViewController: UIViewController {
    

    var secondsPerTime:Int = 8;
    var escapeMillis:Int = 0;
    var isTraining = false;
    var timer:NSTimer = NSTimer();
    var startMillis:Int = 0;
    
    @IBOutlet weak var finishedCountLabel: UILabel!
    @IBOutlet weak var trainPlanLabel: UILabel!
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        circularProgressView.value = 0.0
        fetchFinishTrainCount()
        

    }
    
    override func viewDidAppear(animated: Bool) {
        self.parentViewController!.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "first"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showSettingController"))
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.parentViewController!.navigationItem.rightBarButtonItem = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSettingController(){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("trainPlanSettingNavController"
        ))!,animated: true, completion: nil)
    }
    
    
    @IBAction func startButtonClick(sender: AnyObject) {
        //circularProgressView.value = circularProgressView.value + 0.1
        
        if isTraining{
            isTraining = false
            timer.invalidate()
            startButton.setTitle("开始", forState: .Normal)
            print(escapeMillis)
            let db = DBHelper.sharedInstance
            db.insertDetail("train", startMillis: startMillis, endMillis: startMillis + escapeMillis)
            db.queryTest()
            showFailAlert()
            db.insertOrUpdateDayTrain(escapeMillis)
            db.queryData("train", year: 2015, month: 11)
            escapeMillis = 0
       }else{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateProgress"), userInfo: nil, repeats: true)
            let now = NSDate().timeIntervalSince1970;
            startMillis = Int(now * 1000.0);
            print("startMillis \(startMillis)")
            isTraining = true
            circularProgressView.value = 0.0
            startButton.setTitle("结束", forState: .Normal)
        }
    }
    
    private func showFailAlert(){
        let alert = UIAlertController(title: "tiltle fail", message: "message: fail", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "yes", style: .Default, handler:{(acttion) -> Void in
            print("yes")
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func showFinishAlert(){
        let alert = UIAlertController(title: "恭喜", message: "完成咯", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "yes", style: .Default, handler: {(action) -> Void in print("finish")}))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateProgress(){
        escapeMillis += 10
        if(secondsPerTime > 60){
            circularProgressView.value = CGFloat(CGFloat((escapeMillis % (60 * 1000))) / CGFloat((60 * 1000)))
        }else{
            circularProgressView.value = CGFloat(CGFloat((escapeMillis % (secondsPerTime * 1000))) / CGFloat((secondsPerTime * 1000)))
        }
        
        if(escapeMillis >= secondsPerTime * 1000){
            // trian finish
            isTraining = false
            escapeMillis = 0;
            startButton.setTitle("开始", forState: .Normal)
            timer.invalidate()
            showFinishAlert()
            
        }else if((escapeMillis % (secondsPerTime * 1000)) == 0){
            circularProgressView.value = 0.0
            let tmpColor = circularProgressView.tintColor;
            circularProgressView.tintColor = circularProgressView.progressTint
            circularProgressView.progressTint = tmpColor
            // todo use percentTint
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!){
        case "showHowPost":
            let postWebViewController = segue.destinationViewController.childViewControllers[0] as! PostWebViewController;
            postWebViewController.postID = 13;
            postWebViewController.defaultTitle = "如何完成标准的平板支撑？"
        default:
            super.prepareForSegue(segue, sender: sender)
        }
        
    }
    
    func fetchFinishTrainCount()->Void{
        Alamofire.request(.GET, NSObject.baseURLStr() + "api/train_count")
            .responseJSON(completionHandler: { response in
                if let value = response.result.value {
                    self.finishedCountLabel.text = String(format: Constant.finishedCount, value as! Int)
                    
                }
            })
        
    }

    
}

