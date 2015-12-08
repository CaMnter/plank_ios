//
//  Util.swift
//  plank_iOS
//
//  Created by jiangecho on 15/12/8.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class Util: NSObject {
    public static func showAlert(controller: UIViewController, title:String, msg:String, completion: (() -> Void)?){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler:nil))
        
        controller.presentViewController(alert, animated: true, completion: completion)
    }

}
