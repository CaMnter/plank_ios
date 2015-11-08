//
//  IndicatorStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/08/31.
//  Copyright (c) 2015年 keygx. All rights reserved.
//


public struct IndicatorStyle : StyleProperty {
    // Progress Size
    public var progressSize: CGFloat = 54
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 4.0
    public var startArcColor: UIColor = UIColor(red:90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1.0)
    public var endArcColor: UIColor = UIColor(red:230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    
    // Base Circular
    public var baseLineWidth: CGFloat = 4.0
    public var baseArcColor: UIColor = UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 0.4)
    
    // Ratio
    public var ratioLabelFont: UIFont = UIFont.systemFontOfSize(16.0)
    public var ratioLabelFontColor: UIColor = UIColor.blackColor()
    
    // Message
    public var messageLabelFont: UIFont = UIFont.systemFontOfSize(16.0)
    public var messageLabelFontColor: UIColor = UIColor.blackColor()
    
    // Background
    public var backgroundStyle: BackgroundStyles = .None
    
    public init() {}
}
