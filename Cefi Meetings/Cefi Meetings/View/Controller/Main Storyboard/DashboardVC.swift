//
//  DashboardVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 24/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {

    
    @IBOutlet var optionButtons: [UIButton]!
    @IBOutlet weak var contactCount: UILabel!
    @IBOutlet weak var visitCount: UILabel!
    @IBOutlet weak var contractCount: UILabel!
    @IBOutlet weak var pendingCount: UILabel!
    
    let viewModel = DashboardViewModel()
    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       let apilink = appGlobalVariable.apiBaseURL+"useroverview/useroverviewinfo"
        let userID = appGlobalVariable.userID
        
        let dict = ["userId": userID]
        
        viewModel.populateCounts(API: apilink, TextFields: dict) { (status, result) in
            
            print(result)
            
            self.contactCount.text = String(result!["addedContactsToday"] as! Int)
            self.contractCount.text = String(result?["allOpenContracts"]as! Int)
            self.visitCount.text = String(result?["todayLeftVisits"]as! Int)
            self.pendingCount.text = String(result!["pendingDocument"] as! Int)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    // ********* Switching to Respect selected option Tab index *****************
    @IBAction func buttonAction(_ sender: UIButton) {
        
    self.tabBarController?.selectedIndex = sender.tag
    }
    
    
}
