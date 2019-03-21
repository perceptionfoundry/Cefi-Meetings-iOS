//
//  CalendarVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 13/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController, FSCalendarDelegate{
   
    
    
    
    
    // ****************** OUTLET *****************

    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var NaviBarDate: UILabel!
    
    
    
    var calendarDele : calenderDelegate!
    
    
    // ****************** VIEWDIDLOAD *****************


    override func viewDidLoad() {
        super.viewDidLoad()
        
    calendarView.pagingEnabled = false
        calendarView.scrollDirection = .vertical
        
        calendarView.delegate = self
        
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        
        let today = formatter.string(from: currentDate)
        
        NaviBarDate.text = today
        
        
    }
    
  
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: TimeZone.current.identifier)
        formatter.dateFormat = "yyyy-MM-dd"
       let selected = formatter.string(from: date)
        
        
        let currentDate = date
        let naviDateformatter = DateFormatter()
        formatter.locale = Locale(identifier: TimeZone.current.identifier)
        naviDateformatter.dateStyle = .long
        let today = naviDateformatter.string(from: currentDate)
        
         print(today)
        
        self.navigationController?.popViewController(animated: true)
        
        calendarDele.selectDate(selectedDateValue: selected, NaviDate: today)
        
        
    }
 
    // ****************** BACK ACTION FUNCTION *****************

    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


