//
//  ReminderVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 06/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

protocol ReminderDelegate {
    func reminderValue(minute : String , value : Double)
}

class ReminderVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var reminder_Table: UITableView!
    
    var reminderDele : ReminderDelegate!
    var previousSelect = ""
    var reminderdescrip  = ["0 Min","15 Min", "30 Min", "45 Min", "1 hour",]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminder_Table.delegate = self
        reminder_Table.dataSource = self
        
        reminder_Table.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderdescrip.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "Reminder", for: indexPath) as! ReminderTableViewCell
        
        cell.selectedLabel.isHidden = true
        tableView.separatorStyle = .none
        cell.selectionStyle = .none
        
        if previousSelect == reminderdescrip[indexPath.row]{
            cell.selectedLabel.isHidden = false
        }
        
        
        cell.reminderTitle.text = reminderdescrip[indexPath.row]
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = indexPath.row
        if selectedCell == 0{
            let timeStamp : Double = 0 * 60
            
//            print(timeStamp)
//            print(reminderdescrip[0])
            
            reminderDele.reminderValue(minute : reminderdescrip[0]  , value: timeStamp)
            self.navigationController?.popViewController(animated: true)
        }
        else if selectedCell == 1{
            // min * (mill * sec)
            let timeStamp : Double = 15 * 60 
            
//            print(timeStamp)
//            print(reminderdescrip[1])
            
            reminderDele.reminderValue(minute : reminderdescrip[1]  , value: timeStamp)
            self.navigationController?.popViewController(animated: true)

        }
        else if selectedCell == 2{
            let timeStamp : Double = 30 * 60
//            print(time)

            reminderDele.reminderValue(minute : reminderdescrip[2] , value: timeStamp)
            self.navigationController?.popViewController(animated: true)
        }
        else if selectedCell == 3{
            
            let timeStamp : Double = 45 * 60
//            print(time)

            reminderDele.reminderValue(minute : reminderdescrip[3]  , value: timeStamp)
            self.navigationController?.popViewController(animated: true)

        }
        else if selectedCell == 4{
            
            let timeStamp : Double = 60 * 60
//            print(time)

            reminderDele.reminderValue(minute : reminderdescrip[4] , value: timeStamp)
            self.navigationController?.popViewController(animated: true)

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
