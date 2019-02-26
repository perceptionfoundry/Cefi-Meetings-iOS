//
//  CalendarVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 13/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController{
   
    
    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var NaviBarDate: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    calendarView.pagingEnabled = false
        calendarView.scrollDirection = .vertical
        
        
        
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        
        var today = formatter.string(from: currentDate)
        
        NaviBarDate.text = today
        
        
    }
    
  
    
 
 
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


