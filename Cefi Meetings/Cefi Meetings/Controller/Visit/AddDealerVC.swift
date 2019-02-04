//
//  AddDealerVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class AddDealerVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dealerTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        dealerTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.dismiss(animated: true, completion: nil)
        
        return true
    }
   

}
