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
    
    var didLoadFinish: Bool?
    
    var url = ""
    let htmlTemplateFile = "post.html"
    var htmlTemplateCotent = ""
    
    @IBOutlet weak var webView: UIWebView!
    @IBAction func finish(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.didLoadFinish = false
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

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
        self.didLoadFinish = true
        
        MBProgressHUD.hideHUDForView(self.view, animated: true)

    }
    

}
