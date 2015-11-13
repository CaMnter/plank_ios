//
//  WebViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/13.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBAction func finish(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let url = URL(string: "www.baidu.com")
        let url = NSURL (string: "http://www.baidu.com");
        let requestObj = NSURLRequest(URL: url!);
        //webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.baidu.com")!))
        webView.loadRequest(requestObj)
        //webView.loadHTMLString("hello test", baseURL: nil)
        self.title = "hello webView"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
