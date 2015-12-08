//
//  TimeUtil.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/25.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

class TimeUtil: NSObject {
    static func millisToString(millis:Int) -> String {
        let second = (millis / 1000) % 60
        let minute = (millis / (60 * 1000)) % 60
        let hour = millis / (60 * 60 * 1000)
        
        if hour > 0 {
            return String(format: "%d%02d分%02d秒", hour, minute, second)
        }else{
            return String(format: "%02d分%02d秒", minute, second)
        }
    }
    
    static func millisToString(millis:Int, format:String) ->String {
        let mi = (millis % 1000) / 10
        let second = (millis / 1000) % 60
        let minute = (millis / (60 * 1000)) % 60
        let hour = millis / (60 * 60 * 1000)
        
        if hour > 0 {
            return String(format: format, hour, minute, second)
        }else{
            return String(format: format, minute, second, mi)
        }
    }
}
