//
//  RankTableViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/24.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit
import Alamofire

class RankTableViewController: UITableViewController {
    
    var rankRecordLists:RankRecordList?
    
    @IBAction func exit(sender: AnyObject) {
        self.parentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MBProgressHUD.showHUDAddedTo(self.tableView, animated: true)
        //MBProgressHUD.hideHUDForView(self.tableView, animated: true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.parentViewController?.navigationItem.rightBarButtonItem = self.editButtonItem()
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.parentViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: "exit:")
        fetchRank()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let list = rankRecordLists {
            return list.recordList.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rankCell", forIndexPath: indexPath) as! RankTableViewCell
        let rankRecord = rankRecordLists?.recordList[indexPath.row]
        cell.nameLabel.text = rankRecord?.user.name
        cell.headImageView.sd_setImageWithURL(NSURL(string: (rankRecord?.user.avatar)!))
        
        // Configure the cell...
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func fetchRank(){
        let baseUrl = "http://plank.ngrok.diaoba.wang/"
        Alamofire.request(.GET, baseUrl + "api/challenge/10")
            .responseJSON { response in
                debugPrint(response)
                if let json = response.result.value {
                    let code = json["code"] as! Int
                    if code == 0{
                        self.rankRecordLists = RankRecordList.objectFromJson(json as! NSDictionary)
                        //self.rankRecordLists = NSObject.objectOfClass("RankRecordList", fromJSON: json as! [NSObject : AnyObject]) as! RankRecordList
                        MBProgressHUD.hideAllHUDsForView(self.tableView, animated: true)
                        self.tableView.reloadData()
                    }
                }
        }
    }
    
}
