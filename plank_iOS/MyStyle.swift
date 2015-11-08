//
//  MyStyle.swift
//  plank_iOS
//
//  Created by jiangecho on 15/11/8.
//  Copyright © 2015年 jiangecho. All rights reserved.
//

import Foundation

import GradientCircularProgress

public struct MyStyle : StyleProperty {
    /*** style properties **********************************************************************************/
     
     // Progress Size
    public var progressSize: CGFloat = 200
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 18.0
    public var startArcColor: UIColor = UIColor.darkGrayColor()
    public var endArcColor: UIColor = UIColor.greenColor()
    
    // Base Circular
    public var baseLineWidth: CGFloat = 19.0
    public var baseArcColor: UIColor = UIColor.darkGrayColor()
    
    // Ratio
    public var ratioLabelFont: UIFont = UIFont(name: "Verdana-Bold", size: 16.0)!
    public var ratioLabelFontColor = UIColor.whiteColor()
    
    // Message
    public var messageLabelFont: UIFont = UIFont.systemFontOfSize(16.0)
    public var messageLabelFontColor: UIColor = UIColor.whiteColor()
    
    // Background
    public var backgroundStyle: BackgroundStyles = .Dark
    
    /*** style properties **********************************************************************************/
    
    public init() {}
}