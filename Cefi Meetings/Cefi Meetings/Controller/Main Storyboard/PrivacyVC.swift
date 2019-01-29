//
//  PrivacyVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class PrivacyVC: UIViewController {

    @IBOutlet weak var NaviBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NaviBar.setBackgroundImage(UIImage(), for: .default)
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
