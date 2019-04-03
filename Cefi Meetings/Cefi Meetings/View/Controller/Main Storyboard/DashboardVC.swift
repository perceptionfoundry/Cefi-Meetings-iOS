//
//  DashboardVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 24/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    
    
    // ******************* OUTLET ***************************

    @IBOutlet var optionButtons: [UIButton]!
    @IBOutlet weak var contactCount: UILabel!
    @IBOutlet weak var visitCount: UILabel!
    @IBOutlet weak var contractCount: UILabel!
    @IBOutlet weak var pendingCount: UILabel!
    
    @IBOutlet weak var welcomeNote: UILabel!
    
    
    
    
    
    
    
    
    
    // ******************* VARIABLE ***************************

    let viewModel = DashboardViewModel()
    var profileViewModel = UserSettingViewModel()

    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
    
    
    
    
    
    
    // ******************* VIEWDIDLOAD ***************************

    override func viewDidLoad() {
        super.viewDidLoad()
       
//        self.welcomeNote.text = ""
//
//        let apilink = appGlobalVariable.apiBaseURL+"auth/user?\(appGlobalVariable.userID)"
//
//        let currentDate = Date()
//        let formatter = DateFormatter()
//
//        formatter.dateFormat = "yyyy-MM-dd"
//        let todayDate = formatter.string(from: currentDate)
//
//
//        print(todayDate)
//
//        let paramDict = ["userId" : appGlobalVariable.userID,
//                         "todayDate" : todayDate
//        ]
//
//        profileViewModel.fetchUserProfile(API: apilink, TextFields: paramDict) { (status, err, result) in
//
//
//            //            print(result)
//
//         let name  = result.name!
//
//            self.welcomeNote.text = "Welcome\n\(name)\nWe hope you have a great and productive day!"
//
//        }
    }

    
    
    
    
    
    
    
    // ******************* VIEWWILLAPPEAR ***************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
        
        
        self.welcomeNote.text = ""
        
        let apilink = appGlobalVariable.apiBaseURL+"auth/user?\(appGlobalVariable.userID)"
        
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.string(from: currentDate)
        
        
        print(todayDate)
        
        let paramDict = ["userId" : appGlobalVariable.userID]
        
        profileViewModel.fetchUserProfile(API: apilink, TextFields: paramDict) { (status, err, result) in
            
            
            //            print(result)
            
            let name  = result.name!
            
            self.welcomeNote.text = "Welcome\n\(name)\nWe hope you have a great and productive day!"
            
        }
        
        
        //*************
        
        let userapilink = appGlobalVariable.apiBaseURL+"useroverview/useroverviewinfo"
        let userID = appGlobalVariable.userID
        
        let dict = ["userId": userID,
        "todayDate" : todayDate]
        
        viewModel.populateCounts(API: userapilink, TextFields: dict) { (status, result) in
            
            //            print(result)
            
            self.contactCount.text = String(result!["addedContactsToday"] as! Int)
            self.contractCount.text = String(result?["allOpenContracts"]as! Int)
            self.visitCount.text = String(result?["todayLeftVisits"]as! Int)
            self.pendingCount.text = String(result!["pendingDocument"] as! Int)
        }
    }
    
    
    
    
    
    
    
    
    
    // ********* SWITCH TO RESPECTICE TAB-BAR CONTROLLER INDEX *****************
    @IBAction func buttonAction(_ sender: UIButton) {
        
    self.tabBarController?.selectedIndex = sender.tag
    }
    
    
}
