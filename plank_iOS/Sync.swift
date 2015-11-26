//
//  Sync.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/21.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import Foundation
import Alamofire

class Sync{
    
    let baseUrl = NSObject.baseURLStr()
    static let shareInstance = Sync()
    
    func async() -> Void{
        { self.sync() } ~> { print("synced") }
    }
    
    func sync() -> Void {
        if !Login.isLogin() {
            return
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let sync = userDefaults.objectForKey("sync")
        if (sync != nil) {
            // synced
            uploadDayRecord("train")
            uploadDayRecord("challenge")
            uploadDetailRecord("t_train")
            uploadDetailRecord("t_challenge")
        }else{
            downloadData("train") // t_train on server == train on local
            downloadData("challenge") // t_train on server == train on local
        }
    }
    
    //table: train, challenge
    func uploadDayRecord(table:String) -> Void {
        let pendingSyncData = DBHelper.sharedInstance.queryPendingSyncDayInfo(table)
        
        if pendingSyncData.count == 0 {
            return
        }
        
        let dict:NSMutableDictionary = NSMutableDictionary()
        dict.setValue(0, forKey: "code")
        dict.setValue(table, forKey: "table")
        
        let items:NSMutableArray = NSMutableArray()
        let itemDict: NSMutableDictionary = NSMutableDictionary()
        
        for item in pendingSyncData {
            itemDict.setValue(NSNumber(longLong: item.id), forKey: "id")
            itemDict.setValue(item.timeStamp, forKey: "date")
            itemDict.setValue(NSNumber(longLong: item.timeDuration), forKey: "duration")
            
            items.addObject(itemDict)
        }
        
        dict.setValue(items, forKey: "records")
        
        uploadData(table, dict: dict)
        
        
    }
    
    //table: t_train, t_challenge
    func uploadDetailRecord(table:String) -> Void {
        let pendingSyncData = DBHelper.sharedInstance.queryPendingSyncDetail(table)
        if pendingSyncData.count == 0 {
            return
        }
        
        let dict:NSMutableDictionary = NSMutableDictionary()
        dict.setValue(0, forKey: "code")
        dict.setValue(table, forKey: "table")
        
        let items:NSMutableArray = NSMutableArray()
        let itemDict: NSMutableDictionary = NSMutableDictionary()
        
        for item in pendingSyncData {
            itemDict.setValue(NSNumber(longLong: item.id), forKey: "id")
            itemDict.setValue(NSNumber(longLong: item.startMillis), forKey: "startMillis")
            itemDict.setValue(NSNumber(longLong: item.endMillis), forKey: "endMillis")
            
            items.addObject(itemDict)
        }
        
        dict.setValue(items, forKey: "records")
        
        uploadData(table, dict: dict)
        
    }
    
    func uploadData(table:String, dict:NSDictionary) -> Void {
        let request = NSMutableURLRequest(URL: NSURL(string: baseUrl + "api/sync/upload")!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // TODO maybe need to handle cookie, but i am confused why the request inlcude the cookie
        // set cookie: http://stackoverflow.com/questions/28927887/alamofire-request-with-cookies
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(dict, options: [])
        Alamofire.request(request)
            .responseJSON(completionHandler: { response in
                // TODO
                if let json = response.result.value{
                    let code:Int = json["code"] as! Int
                    if code == 0 {
                        var ids:[Int64] = [Int64]()
                        let items = dict.objectForKey("records") as! NSArray
                        for item in items {
                            ids.append(item.objectForKey("id")!.longLongValue)
                        }
                        DBHelper.sharedInstance.updateSyncStatus(table, ids: ids)
                    }
                }
            })
    }
    
    func downloadData(table:String){
        let serverTable = DBHelper.convert2ServerTableName(table)
        Alamofire.request(.GET, baseUrl + "api/sync/download/\(serverTable)")
            .responseJSON(completionHandler: { response in
                if let json = response.result.value {
                    let code:Int = json["code"] as! Int
                    
                    if code == 0 {
                        let records = json["records"] as? NSArray
                        //let table = json["table"] as! String
                        DBHelper.sharedInstance.insertDayRecords(table, records: records)
                        let userDefaults = NSUserDefaults.standardUserDefaults()
                        userDefaults.setValue("synced", forKey: "sync")
                    }
                }
            })
    }
    
}

