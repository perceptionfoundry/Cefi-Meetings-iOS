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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
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
