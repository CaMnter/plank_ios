//
//  DBHelper.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/10.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import SQLite
import Foundation


let COLUMN_NAME_TIMESTAMP = "timestamp"
let COLUMN_NAME_TIME_DURATION = "timeDuration"
let COLUMN_NAME_START_MILLIS = "startMillis"
let COLUMN_NAME_END_MILLIS = "endMillis"
let COLUMN_NAME_SYNC = "sync"

let TABLE_TRAIN = "train";
let TABLE_CHALLENGE = "challenge";
let TABLE_TRAIN_DETAIL = "t_train"; // train detail
let TABLE_CHALLENGE_DETAIL = "t_challenge"; // challenge detail

let STATUS_PENDING_SYNC = 0
let STATUS_SYNCED = 1

let CREATE_TRAIN_TABLE:String = "CREATE TABLE IF NOT EXISTS \(TABLE_TRAIN) (_id INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_NAME_TIMESTAMP) date UNIQUE, \(COLUMN_NAME_TIME_DURATION) LONG, \(COLUMN_NAME_SYNC) INT  default \(STATUS_PENDING_SYNC))"

let CREATE_CHALLENGE_TABLE:String = "CREATE TABLE IF NOT EXISTS \(TABLE_CHALLENGE) (_id INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_NAME_TIMESTAMP) date UNIQUE, \(COLUMN_NAME_TIME_DURATION) LONG, \(COLUMN_NAME_SYNC) INT  default \(STATUS_PENDING_SYNC))"

let CREATE_TRAIN_DETAIL_TABLE:String = "CREATE TABLE IF NOT EXISTS \(TABLE_TRAIN_DETAIL) (_id INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_NAME_START_MILLIS) BIGINT, \(COLUMN_NAME_END_MILLIS)  BIGINT, \(COLUMN_NAME_SYNC) INT DEFAULT \(STATUS_PENDING_SYNC))"
let CREATE_CHALLENGE_DETAIL_TABLE:String = "CREATE TABLE IF NOT EXISTS \(TABLE_CHALLENGE_DETAIL) (_id INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_NAME_START_MILLIS) BIGINT, \(COLUMN_NAME_END_MILLIS)  BIGINT, \(COLUMN_NAME_SYNC) INT DEFAULT \(STATUS_PENDING_SYNC))"

let path = NSSearchPathForDirectoriesInDomains(
    .DocumentDirectory, .UserDomainMask, true
    ).first!


class DBHelper{
    
    static let sharedInstance = DBHelper()
    
    var db:Connection?
    
    init(){
//        let filemgr = NSFileManager.defaultManager()
//        var needCreateTable = false
        print(path)
//        if !filemgr.fileExistsAtPath(path + "/db.sqlite3"){
//            needCreateTable = true
//        }
        do{
            let db = try Connection("\(path)/db.sqlite3")
            //if needCreateTable{
                try db.transaction(block: {
                    try db.execute(CREATE_TRAIN_TABLE)
                    try db.execute(CREATE_CHALLENGE_TABLE)
                    try db.execute(CREATE_TRAIN_DETAIL_TABLE)
                    try db.execute(CREATE_CHALLENGE_DETAIL_TABLE)
                })
            //}
            self.db = db
        }catch{
            print("db init error")
        }
    }
    
    func insertDetail(table:String, startMillis: Int, endMillis: Int){
        let sql = "INSERT INTO \(TABLE_TRAIN_DETAIL) (\(COLUMN_NAME_START_MILLIS) , \(COLUMN_NAME_END_MILLIS)) VALUES ( \(startMillis) , \(endMillis))";
        do{
            try db?.execute(sql)
            print("hello")
            print("world \(db?.totalChanges)")
        }catch{
            print("insert detail error")
        }
    }
    
    func insertTrainDetail(startMillis:Int, endMillis: Int){
        insertDetail(TABLE_TRAIN_DETAIL, startMillis: startMillis, endMillis:endMillis)
    }
    
    func insertChallengeDetail(startMillis:Int, endMillis: Int){
        insertDetail(TABLE_CHALLENGE_DETAIL, startMillis:startMillis, endMillis:endMillis)
    }
    
    func insertOrUpdate(table:String, duration:Int){
        let insert = "INSERT OR IGNORE INTO \(table) (timestamp, timeDuration) VALUES (date(), \(duration))";
        let update = "UPDATE \(table) SET timeDuration = timeDuration + \(duration), sync = 0 WHERE timestamp = date()";
        do{
            try db?.transaction(block: {
                try self.db?.execute(update)
                
                print("tt \(self.db?.totalChanges)")
                if self.db?.changes == 0{
                    try self.db?.execute(insert)
                }
            })
            print("toalChanges: \(db?.changes)")
        }catch{
            print("insert day info error")
        }
    }
    
    func insertOrUpdateDayTrain(duration:Int){
        insertOrUpdate(TABLE_TRAIN, duration: duration)
    }
    
    func insertOrUpdateDayChallenge(duration:Int){
        insertOrUpdate(TABLE_TRAIN, duration: duration)
    }
    
    func queryTest(){
        let sql = "SELECT * FROM t_train"
        let tmp = db?.prepare(sql)
        for row in tmp!{
            print("id: \(row[0]), start: \(row[1]), end: \(row[2])")
        }
        print("totalChanges: \(db?.totalChanges)")
    }
    
    func queryData(table:String, year:Int, month:Int) -> [String: Int64]{
        let sql:String = String(format: "SELECT timestamp, timeDuration FROM %@ WHERE strftime('%%Y-%%m', timestamp) = '%d-%2d'", table, year, month)
        var result = [String: Int64]()
        //let sql = "select strftime('%m', timestamp), timeDuration from train"
        let tmp = db?.prepare(sql)
        
        for row in tmp!{
            result[row[0] as! String] = row[1] as? Int64
        }
        
        // TODO need to sort by yourself
        return result
    }
    
    func queryPendingSyncDetail(table:String) -> [(id: Int64,  startMillis: Int64, endMillis: Int64)]{
        let sql:String = String(format: "SELECT _id, startMillis, endMillis from \(table) WHERE sync = 0")
        var result = [(id: Int64,  startMillis: Int64, endMillis: Int64)]()
        
        let tmp = db?.prepare(sql)
        for row in tmp! {
            result.append((row[0] as! Int64, row[1] as! Int64, row[2] as! Int64))
        }
    
        return result
    }
    
    func queryPendingSyncDayInfo(table:String) -> [(id:Int64, timeStamp:String, timeDuration:Int64 )]{
        let sql:String = String(format: "SELECT _id, timestamp, timeDuration from \(table) WHERE sync = 0")
        var result = [(id: Int64,  timeStamp: String, timeDuration: Int64)]()
        
        let tmp = db?.prepare(sql)
        for row in tmp! {
            result.append((row[0] as! Int64, row[1] as! String, row[2] as! Int64))
        }
    
        return result
    }
    
    func updateSyncStatus(table:String, ids: [Int64]) -> Void{
        
        if ids.count == 0 {
            return
        }
        
        var sql:String = String(format: "UPDATE \(table) SET sync = 1 WHERE _id in ")
        
        sql.appendContentsOf("( ")
        for var i = 0; i < ids.count; i++ {
            sql.appendContentsOf("\(ids[i])")
            
            if i < (ids.count - 1) {
                sql.appendContentsOf(", ")
            }
        }
        
        sql.appendContentsOf(" )")
        
        do{
            try db?.execute(sql)
            
        }catch{
        }
    }
    
    func queryData(table:String, date: NSDate, delegate:LoadDataProtocol?){
        
        let components = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month], fromDate: date)
        let year = components.year
        let month = components.month
        
        let result = queryData(table, year: year, month: month)
        delegate?.didDataLoadFinish(table, date: date, result: result)
    }
}
