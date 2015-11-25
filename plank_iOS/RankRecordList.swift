//
//  RankRecordList.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/25.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import Foundation
@objc(RankRecordList)
class RankRecordList:NSObject {
    var code:Int = -1
    var recordList:[RankRecord] = []
    
//    override init(){
//        code = -1
//        recordList = []
//    }
    
    static func objectFromJson(json: NSDictionary) -> RankRecordList{
        let rankRecordList = RankRecordList()
        rankRecordList.code = json["code"] as! Int
        
        rankRecordList.recordList = [RankRecord]()
        let list = json["recordList"] as! NSArray
        for element in list {
            rankRecordList.recordList.append(RankRecord.objectFromJson(element as! NSDictionary))
        }
        
        return rankRecordList
    }
}
