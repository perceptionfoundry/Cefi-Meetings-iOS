//
//  NewContactVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class NewContactVC: UIViewController {

    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var businessName: UITextField!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var industryCategory: UITextField!
    @IBOutlet weak var typeCategory: UITextField!
    @IBOutlet weak var referredBy: UITextField!
    
    
    
    
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
