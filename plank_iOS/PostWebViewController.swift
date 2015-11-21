//
//  WebViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/13.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit
import Alamofire

class PostWebViewController: UIViewController {
    
    let postBaseUrl = "http://plankmp.sinaapp.com/?json=get_post&post_id=%d";
    let htmlTemplateFile = "post.html"
    var htmlTemplateCotent = ""
    var postID:Int = 0;
    var defaultTitle:String = ""
    
    var didLoadFinish: Bool?
    var timer: NSTimer?
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: UIWebView!
    @IBAction func finish(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = defaultTitle
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        
        //reading
        if htmlTemplateCotent == ""{
            do {
                htmlTemplateCotent = try String(contentsOfFile: NSBundle.mainBundle().pathForResource("post.html", ofType: nil, inDirectory: "html")!, encoding: NSUTF8StringEncoding)
            }
            catch {/* error handling here */}
        }
        self.didLoadFinish = false
        self.progressView.progress = 0
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1667, target: self, selector: "timerCallback", userInfo: nil, repeats: true)
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        Alamofire.request(.GET, String(format:postBaseUrl, postID), parameters: nil)
            .responseJSON { response in
                //                print(response.request)  // original URL request
                //                print(response.response) // URL response
                //                print(response.data)     // server data
                //                print(response.result)   // result of response serialization
                
                //response.result.value!["content"]
                if let json = response.result.value {
                    if let post = json["post"] {
                        let content:String = post!["content"] as! String
                        let title:String  = post!["title"] as! String
                        self.title = title
                        let tmp = self.htmlTemplateCotent.stringByReplacingOccurrencesOfString("content", withString: content)
                        self.webView.loadHTMLString(tmp, baseURL: nil)
                        
                        self.didLoadFinish = true

                    }
                }
        }
    }
        func timerCallback() {
        if self.didLoadFinish! {
            if self.progressView.progress >= 1 {
                self.progressView.hidden = true
                self.timer!.invalidate()
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
