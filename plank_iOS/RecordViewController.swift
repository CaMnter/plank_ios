//
//  RecordViewController.swift
//  CVCalendar Demo
//
//  Created by Мак-ПК on 1/3/15.
//  Copyright (c) 2015 GameApp. All rights reserved.
//

import UIKit
import CVCalendar

class RecordViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!

    var shouldShowDaysOut = false
    var animationFinished = true
    
    var trainData:Dictionary<NSDate, Dictionary<String, Int64>> = [:]
    var currentDate:NSDate = NSDate();
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
        
        //DBHelper.sharedInstance.queryData("train", date: NSDate(), delegate: self)

    }
    @IBAction func test(sender: AnyObject) {
        self.shouldShowDaysOut = !self.shouldShowDaysOut
    }
}

extension RecordViewController: LoadDataProtocol {
    func didDataLoadFinish(table: String, date: NSDate, result: Dictionary<String, Int64>) {
        // TODO
        trainData[date] = result
        self.calendarView.toggleViewWithDate(date)
        //self.calendarView.commitCalendarViewUpdate()
    }
}


// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

extension RecordViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Monday
    }
    
    // MARK: Optional methods
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selected!")
    }
    
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
//        let day = dayView.date.day
//        let randomDay = Int(arc4random_uniform(31))
//        if day == randomDay {
//            return true
//        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
            return [color, color, color]
        default:
            return [color] // return 1 dot
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 13
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .Short
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        let π = M_PI
        
        let ringSpacing: CGFloat = 5.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 0.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 1.0
        let ringLineColour: UIColor = .blueColor()
        
        let newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor
        
        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        // TODO check whether show supplementary view or not?
//        if (Int(arc4random_uniform(3)) == 1) {
//            return true
//        }
        
        let monthTrainData = trainData[currentDate]
        if dayView.date != nil{
            let year = dayView.date.year
            let month = dayView.date.month
            let day = dayView.date.day
            let date:String = String(format: "%d-%2d-%2d", year, month, day)
            let dayTrainData = monthTrainData?[date]
        
            return dayTrainData > 0 ? true : false
        }else{
            return false
        }
        
    }
}


// MARK: - CVCalendarViewAppearanceDelegate

extension RecordViewController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - IB Actions

//extension RecordViewController {
//    @IBAction func switchChanged(sender: UISwitch) {
//        if sender.on {
//            calendarView.changeDaysOutShowingState(false)
//            shouldShowDaysOut = true
//        } else {
//            calendarView.changeDaysOutShowingState(true)
//            shouldShowDaysOut = false
//        }
//    }
//    
//    @IBAction func todayMonthView() {
//        calendarView.toggleCurrentDayView()
//    }
//    
//    /// Switch to WeekView mode.
//    @IBAction func toWeekView(sender: AnyObject) {
//        calendarView.changeMode(.WeekView)
//    }
//    
//    /// Switch to MonthView mode.
//    @IBAction func toMonthView(sender: AnyObject) {
//        calendarView.changeMode(.MonthView)
//    }
//    
//    @IBAction func loadPrevious(sender: AnyObject) {
//        calendarView.loadPreviousView()
//    }
//    
//    
//    @IBAction func loadNext(sender: AnyObject) {
//        calendarView.loadNextView()
//    }
//}

// MARK: - Convenience API Demo

extension RecordViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    func didShowNextMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        self.currentDate = date
        
        DBHelper.sharedInstance.queryData("train", date: date, delegate: self)
        print("Showing Month: \(components.month)")
    }
    
    
    func didShowPreviousMonthView(date: NSDate)
    {
        //        let calendar = NSCalendar.currentCalendar()
        //        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(date) // from today
        self.currentDate = date
        
        DBHelper.sharedInstance.queryData("train", date: date, delegate: self)
        print("Showing Month: \(components.month)")
    }
    
}