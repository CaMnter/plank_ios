//
//  PlanTableViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/29.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class TrainPlanSettingTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var trainSecondPerTimeLabel: UILabel!
    @IBOutlet weak var restSecondPerTimeLabel: UILabel!
    @IBOutlet weak var timesLabel: UILabel!
    
    enum SettingType : String {
        case TrainSecondPerTime
        case RestSecondPerTime
        case Times
        
    }
    
    @IBAction func exit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "训练设置"
        updateSettingLabels()
    }
    
    func updateSettingLabels(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let trainSecondPerTime = userDefaults.objectForKey(SettingType.TrainSecondPerTime.rawValue) {
            trainSecondPerTimeLabel.text = String(trainSecondPerTime)
            
        }
        
        if let restSecondPerTime = userDefaults.objectForKey(SettingType.RestSecondPerTime.rawValue) {
            print(restSecondPerTime)
            restSecondPerTimeLabel.text = String(restSecondPerTime)
        }
        
        if let times = userDefaults.objectForKey(SettingType.Times.rawValue) {
            timesLabel.text = String(times)
            print(times)
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        
        switch section {
        case 0:
            let row = indexPath.row
            var type:SettingType?
            switch row {
            case 0:
                type = SettingType.TrainSecondPerTime
            case 1:
                type = SettingType.RestSecondPerTime
            case 2:
                type = SettingType.Times
            default:
                break
            }
            if (type != nil) {
                showSettingAlert(type!)
            }
        default:
            break
            //super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    private func showSettingAlert(type:SettingType){
        var currentLabel:UILabel
        var title:String
        
        switch type{
            case SettingType.TrainSecondPerTime:
                currentLabel = self.trainSecondPerTimeLabel
                title = "一次训练多长时间(秒)"
            case .RestSecondPerTime:
                currentLabel = self.restSecondPerTimeLabel
                title = "每次休息多长时间(秒)"
            case .Times:
                currentLabel = self.timesLabel
                title = "一次多少组"
            }
 
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .Alert)

        alert.addTextFieldWithConfigurationHandler({(textField)->Void in
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.delegate = self
        })
        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: {(action) -> Void in
            // TODO store in userDefaults
            let tmp = alert.textFields![0].text
            print(tmp)
            
            let text:String? = alert.textFields![0].text
            var value:Int? = -1
            if (text ?? "").isEmpty {
                return
            }else{
                value = Int(text!)
            }
            
            if value > 0 {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setInteger(value!, forKey: type.rawValue)
            }
            
            currentLabel.text = text
          
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!){
        case "showHowToPlank":
            let postWebViewController = segue.destinationViewController as! PostWebViewController;
            postWebViewController.postID = 13;
            postWebViewController.defaultTitle = "如何完成标准的平板支撑？"
        default:
            super.prepareForSegue(segue, sender: sender)
        }
        
    }
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            
            // do not allow to start with "0"
            if range.location == 0 && string == "0" {
                return false
            }
            
            // Create an `NSCharacterSet` set which includes everything *but* the digits
            let inverseSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
            
            // At every character in this "inverseSet" contained in the string,
            // split the string up into components which exclude the characters
            // in this inverse set
            let components = string.componentsSeparatedByCharactersInSet(inverseSet)
            
            // Rejoin these components
            let filtered = components.joinWithSeparator("")  // use join("", components) if you are using Swift 1.2
            
            // If the original string is equal to the filtered string, i.e. if no
            // inverse characters were present to be eliminated, the input is valid
            // and the statement returns true; else it returns false
            return string == filtered
            
    }
    
}
