//
//  RankRecord.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/25.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

@objc(RankRecord)
class RankRecord:NSObject {
    var code:Int!
    var startMillis:Int!
    var endMillis:Int!
    
    var user:User
    
    override init() {
        code = -1
        startMillis = -1
        endMillis = -1
        user = User()
    }
    
    static func objectFromJson(json:NSDictionary) -> RankRecord{
        let record = RankRecord()
        record.code = json["code"] as! Int;
        record.startMillis = json["startMillis"] as! Int
        record.endMillis = json["endMillis"] as! Int
        let owner:NSDictionary = json["owner"] as! NSDictionary
        record.user = NSObject.objectOfClass("User", fromJSON: owner as [NSObject : AnyObject] ) as! User
        return record
    }
}
