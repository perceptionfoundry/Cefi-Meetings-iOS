//
//  ReferralNewContactVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 31/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class ReferralNewContactVC: UIViewController {
    
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var businessName: UITextField!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var industryCategory: UITextField!
    @IBOutlet weak var streetCategory: UITextField!
    @IBOutlet weak var townCity: UITextField!
    @IBOutlet weak var Territory: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func doneAction(_ sender: Any) {
    }
    @IBAction func cancelAction(_ sender: Any) {
        
        //        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

