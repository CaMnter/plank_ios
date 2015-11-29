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
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        
        switch section {
        case 0:
            showSettingAlert(SettingType.TrainSecondPerTime)
        default:
            super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        }
    }
    
    private func showSettingAlert(type:SettingType){
        let alert = UIAlertController(title: "恭喜", message: nil, preferredStyle: .Alert)

        alert.addTextFieldWithConfigurationHandler({(textField)->Void in
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.delegate = self
        })
        alert.addAction(UIAlertAction(title: "yes", style: .Default, handler: {(action) -> Void in
            // TODO store in userDefaults
            let tmp = alert.textFields![0].text
            print(tmp)
            
            let text:String? = alert.textFields![0].text
            var value:Int? = -1
            if (text != nil) {
                value = Int(text!)
            }else{
                return
            }
            
            if value > 0 {
                let userDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setInteger(value!, forKey: type.rawValue)
            }
            
            switch type{
            case SettingType.TrainSecondPerTime:
                self.trainSecondPerTimeLabel.text = text
            case .RestSecondPerTime:
                self.restSecondPerTimeLabel.text = text
            case .Times:
                self.timesLabel.text = text
            }
           
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            
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
