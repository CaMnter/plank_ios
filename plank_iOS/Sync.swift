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
    
    let baseUrl = "http://plank.ngrok.diaoba.wang/"
    static let shareInstance = Sync()
    
    func syncTrainAndChallengeData() ->Void {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            // TODO query db and sync
            // only need to download from server one time(the first time)
            // then send data to server
            let userDefaults = NSUserDefaults.standardUserDefaults()
            var sync = userDefaults.objectForKey("sync")
            userDefaults.setObject(1, forKey: "sync")
            userDefaults.synchronize()
            sync = userDefaults.objectForKey("sync")
            sync = 2
        })
        
    }
    
    func test() -> Void{
        { print("back") } ~> { print("main") }
    }
    
    func sync() -> Void {
        uploadDayRecord("train")
        
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
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: baseUrl + "api/sync/upload")!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(dict, options: [])
        Alamofire.request(request)
            .responseJSON(completionHandler: { response in
            // TODO
            if let json = response.result.value{
                let code:Int = json["code"] as! Int
                if code == 0 {
                    var ids:[Int64] = [Int64]()
                    for item in pendingSyncData {
                        ids.append(item.id)
                    }
                    DBHelper.sharedInstance.updateSyncStatus(table, ids: ids)
                }
            }
        })
        
        //        let jsonClient:CodingNetAPIClient = CodingNetAPIClient.sharedJsonClient() as! CodingNetAPIClient
        //        jsonClient.requestJsonDataWithPath("/api/sync/upload", withParams: dict as [NSObject : AnyObject], withMethodType: NetworkMethod(1), andBlock: {
        //            (data, error) -> Void in
        //            // TODO
        //            if let data = data {
        //                let code:Int = data.objectForKey("code") as! Int
        //                if code == 0 {
        //                    // success
        //                }
        //
        //            }
        //
        //
        //        })
        
    }
    
    //table: t_train, t_challenge
    func uploadDetailRecord(table:String) -> Void {
        
    }
    
    func jsonStringify(data: NSData) -> NSData? {
        
        do {
            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSData{
                return jsonResult
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
}

