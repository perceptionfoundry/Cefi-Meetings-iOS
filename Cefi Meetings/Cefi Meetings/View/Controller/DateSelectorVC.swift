//
//  DateSelectorVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 27/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit


protocol dateFetching {
    func dateValue(Date: String)
}

class DateSelectorVC: UIViewController {

   
        
        // Initialize Variable
        var  selectedDate : String?
        var dateDelegate : dateFetching?
        
        // Initialize Component
        @IBOutlet weak var datePicker: UIDatePicker!
        
        
        
        
        
        //
        override func viewDidLoad() {
            super.viewDidLoad()
            
            datePicker.datePickerMode = .date
            
            
            
            let Format = DateFormatter()
            Format.dateFormat = "dd-MM-YYYY"
            
            let currentDate = Date()
            
            self.selectedDate = Format.string(from: currentDate)
        }
        
        
        
        
        // Picker view function
        
        @IBAction func pickerAction(_ sender: Any) {
            let format = DateFormatter()
            
            format.dateFormat = "dd-MM-YYYY"
            let date = format.string(from: datePicker.date)
            self.selectedDate = date
            
        }
        
        
        
        
        // Confirm button Action
        @IBAction func ConfirmAction(_ sender: Any) {
            
            if self.selectedDate != nil{
                
                
                print((self.selectedDate)!)
                dateDelegate?.dateValue(Date: (self.selectedDate)!)
                self.dismiss(animated: true, completion: nil)
                
            }
            else{
                let Alert = UIAlertController(title: "Warning", message: "Select your Desire Date", preferredStyle: .alert)
                let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                Alert.addAction(actionButton)
                self.present(Alert, animated: true, completion: nil)
            }
            
            
        }
        
    }


