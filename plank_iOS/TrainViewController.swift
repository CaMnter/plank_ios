//
//  FirstViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/8.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit
class TrainViewController: UIViewController {
    
    var secondsPerTime:Double = 8;
    var escapeMillis:Double = 0.0;
    var isTraining = false;
    var timer:NSTimer = NSTimer();
    
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        circularProgressView.value = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startButtonClick(sender: AnyObject) {
        //circularProgressView.value = circularProgressView.value + 0.1
        
        if isTraining{
            isTraining = false
            timer.invalidate()
            escapeMillis = 0
            startButton.setTitle("开始", forState: .Normal)
            print(escapeMillis)
            showFailAlert()
        }else{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateProgress"), userInfo: nil, repeats: true)
            isTraining = true
            circularProgressView.value = 0.0
            startButton.setTitle("结束", forState: .Normal)
        }
    }
    
    private func showFailAlert(){
        let alert = UIAlertController(title: "tiltle fail", message: "message: fail", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "yes", style: .Default, handler:{(acttion) -> Void in
            print("yes")}))
        
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
            circularProgressView.value = CGFloat((escapeMillis % (60 * 1000)) / (60 * 1000))
        }else{
            circularProgressView.value = CGFloat((escapeMillis % (secondsPerTime * 1000)) / (secondsPerTime * 1000))
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
    
    
}

