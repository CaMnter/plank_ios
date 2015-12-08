//
//  FirstViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/8.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit
import Alamofire

class TrainViewController: UIViewController, SFCountdownViewDelegate {
    
    let trainPlanInfo = "每组%d次 每次%d秒"

    var secondsPerTime:Int = 30
    var restSecondsPerTime:Int = 30
    var times:Int = 3
    var escapeMillis:Int = 0
    var isTraining = false
    var timer:NSTimer = NSTimer()
    var startMillis:Int64 = 0
    var currentTime:Int = 0

    
    @IBOutlet weak var finishedCountLabel: UILabel!
    @IBOutlet weak var trainPlanLabel: UILabel!
    @IBOutlet weak var sfCountdownView: SFCountdownView!
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        circularProgressView.customeLabelValue = true
        circularProgressView.value = 0.0
        circularProgressView.updateLabel("00:00.00")
        circularProgressView.percentLabel?.hidden = false
        fetchFinishTrainCount()
        
        self.sfCountdownView.delegate = self
        self.sfCountdownView.hidden = true
        
        self.circularProgressView.progressTint = UIColor(colorLiteralRed: 0.27, green: 0.75, blue: 0.61, alpha: 1.0)
        self.circularProgressView.trackTint = UIColor(colorLiteralRed: 0.82, green: 0.82, blue: 0.82, alpha: 1.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.parentViewController!.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "first"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showSettingController"))
        updatePlanInfo()
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
        let parentController:EasePageViewController = self.parentViewController as!EasePageViewController
        
        if parentController.childViewControllers.count > 1 {
            let challengeController:ChallengeViewController = parentController.childViewControllers[1] as! ChallengeViewController
        
            if challengeController.isChallenging{
                Util.showAlert(self, title: "失败", msg: "请先完成挑战", completion: nil)
                return
            }
        }
       
        if isTraining{
            isTraining = false
            currentTime = 0
            escapeMillis = 0
            timer.invalidate()
            startButton.setTitle("开始", forState: .Normal)
            showFailAlert()
           
       }else{

            let now = NSDate().timeIntervalSince1970;
            startMillis = Int64(now * 1000.0);
            print("startMillis \(startMillis)")
            isTraining = true
            startButton.setTitle("结束", forState: .Normal)
            startTrain()
        }
    }
    
    private func startTrain(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateProgress"), userInfo: nil, repeats: true)
        circularProgressView.value = 0.0
    
    }
    
    private func showFailAlert(){
        let alert = UIAlertController(title: "训练未完成", message: "哎，训练未完成，加油呀", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler:{(acttion) -> Void in
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func showFinishAlert(){
        let alert = UIAlertController(title: "恭喜", message: "训练完成，坚持!", preferredStyle: .Alert)
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
        
        circularProgressView.updateLabel(TimeUtil.millisToString(escapeMillis, format: "%02d:%02d.%02d"))
        
        if((escapeMillis % (secondsPerTime * 1000)) == 0){
            circularProgressView.value = 0.0
            let tmpColor = circularProgressView.trackTint;
            circularProgressView.trackTint = circularProgressView.progressTint
            circularProgressView.progressTint = tmpColor
            // todo use percentTint
            
            finishOneTimeTrain()
        }
    }
    
    func finishOneTimeTrain(){
        currentTime++
        if currentTime < times{
            timer.invalidate()
            showRestCountDownView(restSecondsPerTime)
        }else{
             // trian finish
            isTraining = false

            startButton.setTitle("开始", forState: .Normal)
            timer.invalidate()
            currentTime = 0

            let db = DBHelper.sharedInstance
            db.insertDetail("train", startMillis: startMillis, endMillis: startMillis + escapeMillis)
            db.insertOrUpdateDayTrain(escapeMillis)
            escapeMillis = 0;

            showFinishAlert()
        }
    }
    
    func updatePlanInfo(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        var tmp =  userDefaults.objectForKey(TrainPlanSettingTableViewController.SettingType.TrainSecondPerTime.rawValue) as? Int
        if (tmp != nil){
            secondsPerTime = tmp!
        }
        tmp = userDefaults.objectForKey(TrainPlanSettingTableViewController.SettingType.RestSecondPerTime.rawValue) as? Int
        
        if tmp != nil{
            restSecondsPerTime = tmp!
        }
        tmp = userDefaults.objectForKey(TrainPlanSettingTableViewController.SettingType.Times.rawValue) as? Int
        if tmp != nil{
            
            times = tmp!
        }
        
        trainPlanLabel.text = String(format: trainPlanInfo, times, secondsPerTime)
        
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
    
    
    func showRestCountDownView(secconds:Int){
        self.sfCountdownView.hidden = false
        self.sfCountdownView.countdownFrom = Int32(restSecondsPerTime)
        self.sfCountdownView.start()
    }
    
    func countdownFinished(view: SFCountdownView!) {
        self.sfCountdownView.hidden = true
        startTrain()
    }
}

