//
//  DateUtil.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/12.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import Foundation

class DateUtil{
    static func getYearMonthString(date: NSDate)->String{
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month], fromDate: date)
        
        //return "\(components.year)-\(components.month)"
        return String(format: "%d-%02d", components.year, components.month)
    }
    
    static func getYearMonthDayString(date: NSDate) -> String{
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, .Day], fromDate: date)
        //return "\(components.year)-\(components.month)"
        return String(format: "%d-%02d-%02d", components.year, components.month, components.day)
    }
}
