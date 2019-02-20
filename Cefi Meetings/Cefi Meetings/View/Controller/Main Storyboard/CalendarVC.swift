//
//  CalendarVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 13/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import FSCalendar
import VACalendar

class CalendarVC: UIViewController,VAMonthHeaderViewDelegate, VADayViewAppearanceDelegate{
    func didTapNextMonth() {
        
    }
    
    func didTapPreviousMonth() {
        
    }
    

    
    @IBOutlet weak var monthHeaderView: VAMonthHeaderView! {
        didSet {
            let appereance = VAMonthHeaderViewAppearance(
//                previousButtonImage: #imageLiteral(resourceName: "previous"),
//                nextButtonImage: #imageLiteral(resourceName: "next")
//                dateFormatter: "llll"
            )
            monthHeaderView.delegate = self
            monthHeaderView.appearance = appereance
        }
    }
    
    @IBOutlet weak var weekDaysView: VAWeekDaysView! {
        didSet {
            let appereance = VAWeekDaysViewAppearance(symbolsType: .veryShort, calendar: defaultCalendar)
            weekDaysView.appearance = appereance
        }
    }
    
    var calendarView: VACalendarView!

    
    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 1
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = true
        calendarView.selectionStyle = .multi
        calendarView.monthDelegate = monthHeaderView
        calendarView.dayViewAppearanceDelegate = self as! VADayViewAppearanceDelegate
        calendarView.monthViewAppearanceDelegate = self as! VAMonthViewAppearanceDelegate
        calendarView.calendarDelegate = self as! VACalendarViewDelegate
        calendarView.scrollDirection = .vertical
        view.addSubview(calendarView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if calendarView.frame == .zero {
            calendarView.frame = CGRect(
                x: 0,
                y: weekDaysView.frame.maxY,
                width: view.frame.width,
                height: view.frame.height * 0.6
            )
            calendarView.setup()
        }
    }
    
 
 
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


