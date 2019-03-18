//
//  PrivacyVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController {

    
    
    
    
    // ****************** OUTLET *****************

    @IBOutlet weak var NaviBar: UINavigationBar!
    
    
    
    
    
    
    // ****************** VIEWDIDLOAD *****************

    
    override func viewDidLoad() {
        super.viewDidLoad()

        NaviBar.setBackgroundImage(UIImage(), for: .default)
        
    }
    

    
    //  *************** BACK BUTTON FUNCTION ************************

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
