//
//  LoadDataProtocol.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/12.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import Foundation
protocol LoadDataProtocol{
    func didDataLoadFinish(table: String, date: NSDate, result: Dictionary<String, Int64>)
}

