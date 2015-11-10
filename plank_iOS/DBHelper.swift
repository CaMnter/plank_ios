//
//  DBHelper.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/10.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import SQLite


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

let CREATE_TRAIN_TABLE:String = "CREATE TABLE IF NOT EXISTS \(TABLE_TRAIN) (_id INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_NAME_TIMESTAMP) date, \(COLUMN_NAME_TIME_DURATION) LONG, \(COLUMN_NAME_SYNC) INT  default \(STATUS_PENDING_SYNC))"

let CREATE_CHALLENGE_TABLE:String = "CREATE TABLE IF NOT EXISTS \(TABLE_TRAIN) (_id INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_NAME_TIMESTAMP) date, \(COLUMN_NAME_TIME_DURATION) LONG, \(COLUMN_NAME_SYNC) INT  default \(STATUS_PENDING_SYNC))"

let CREATE_TRAIN_DETAIL_TABLE:String = "CREATE TABLE \(TABLE_TRAIN_DETAIL) (_id INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_NAME_START_MILLIS) BIGINT, \(COLUMN_NAME_END_MILLIS)  BIGINT, \(COLUMN_NAME_SYNC) INT DEFAULT \(STATUS_PENDING_SYNC))"
let CREATE_CHALLENGE_DETAIL_TABLE:String = "CREATE TABLE \(TABLE_CHALLENGE_DETAIL) (_id INTEGER PRIMARY KEY AUTOINCREMENT, \(COLUMN_NAME_START_MILLIS) BIGINT, \(COLUMN_NAME_END_MILLIS)  BIGINT, \(COLUMN_NAME_SYNC) INT DEFAULT \(STATUS_PENDING_SYNC))"

let path = NSSearchPathForDirectoriesInDomains(
    .DocumentDirectory, .UserDomainMask, true
    ).first!


class DBHelper{
    
    var db:Connection?
    
    func intDB(){
        let filemgr = NSFileManager.defaultManager()
        var needCreateTable = false
        print(path)
        if !filemgr.fileExistsAtPath(path + "/db.sqlite3"){
            needCreateTable = true
        }
        do{
            let db = try Connection("\(path)/db.sqlite3")
            if needCreateTable{
                try db.transaction(block: {
                    try db.execute(CREATE_TRAIN_TABLE)
                    try db.execute(CREATE_CHALLENGE_TABLE)
                    try db.execute(CREATE_TRAIN_DETAIL_TABLE)
                    try db.execute(CREATE_CHALLENGE_DETAIL_TABLE)
                })
            }
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
    
    func queryTest(){
        let sql = "SELECT * FROM t_train"
        do{
            let tmp = db?.prepare(sql)
            for row in tmp!{
                print("id: \(row[0]), start: \(row[1]), end: \(row[2])")
            }
            print("world \(db?.totalChanges)")
        }catch{
            print("insert detail error")
        }
    }
}
