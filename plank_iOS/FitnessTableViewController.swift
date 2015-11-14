//
//  FitnessTableViewController.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/9.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import UIKit

class FitnessTableViewController: UITableViewController {
    
    var fitnesses = [Fitness]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFitness()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 1
        }else{
            return fitnesses.count - 1
        }
    }
    
    func loadFitness(){
        let image1 = UIImage(named: "first")
        let fitness1 = Fitness(title: "title1", desc: "desc1", image: image1)
        
        let image2 = UIImage(named: "second")
        let fitness2 = Fitness(title: "title2", desc: "desc2", image: image2)
        
        let image3 = UIImage(named: "first")
        let fitness3 = Fitness(title: "title3", desc: "desc3", image: image3)
        
        fitnesses += [fitness1!, fitness2!, fitness3!]
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FitnessTableViewCell", forIndexPath: indexPath) as! FitnessTableViewCell
        let fitness = fitnesses[indexPath.row]
        cell.titleLabel.text = fitness.title
        cell.descLabel.text = fitness.desc
        cell.imageView?.image = fitness.image

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    override func tableView( tableView : UITableView,  titleForHeaderInSection section: Int)->String {
        var title:String
        switch(section) {
        case 1:
            title = "跟我练"
        default :
            title = "腹肌撕裂者"
        }
        return title
    }

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
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?{
        // TODO check need to download resource or not
        if indexPath.section == 0 && indexPath.row == 0 {
            let alertController = UIAlertController(title: "ATTENTION", message: "need download resource", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Download", style: UIAlertActionStyle.Default, handler: {(action) in
                print("begain download")
                }
            ))
            presentViewController(alertController, animated: true, completion: nil)
            return nil
        }else{
            return indexPath
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // TODO set the title
        segue.destinationViewController.title = "hello wolrd"
    }

}
