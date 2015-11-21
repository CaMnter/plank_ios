//
//  WebViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/13.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit
import Alamofire

class WebViewControllerSwift: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var progressView: UIProgressView!
    var theBool: Bool?
    var myTimer: NSTimer?
    
    var url = ""
    let htmlTemplateFile = "post.html"
    var htmlTemplateCotent = ""
    
    @IBOutlet weak var webView: UIWebView!
    @IBAction func finish(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theBool = false
        self.progressView.progress = 0
        self.myTimer = NSTimer.scheduledTimerWithTimeInterval(0.1667, target: self, selector: "timerCallback", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func navigationShouldPopOnBackButton() -> Bool {
        if webView.canGoBack {
            webView.goBack()
            return false
        }else{
            return true
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        self.title = title
        self.theBool = true
    }
    
    func timerCallback() {
        if self.theBool! {
            if self.progressView.progress >= 1 {
                self.progressView.hidden = true
                self.myTimer!.invalidate()
            } else {
                self.progressView.progress += 0.1
            }
        } else {
            self.progressView.progress += 0.05
            if self.progressView.progress >= 0.95 {
                self.progressView.progress = 0.95
            }
        }
    }

}
