//
//  FirstViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/8.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit
class FirstViewController: UIViewController {
    
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
        }else{
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateProgress"), userInfo: nil, repeats: true)
            isTraining = true
            circularProgressView.value = 0.0
            startButton.setTitle("结束", forState: .Normal)
        }
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
            
        }else if((escapeMillis % (secondsPerTime * 1000)) == 0){
            circularProgressView.value = 0.0
            let tmpColor = circularProgressView.tintColor;
            circularProgressView.tintColor = circularProgressView.progressTint
            circularProgressView.progressTint = tmpColor
            // todo use percentTint
        }
        
    }

}

