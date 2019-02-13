//
//  userSettingVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class userSettingVC: UIViewController {

    
    @IBOutlet weak var userName: UnderlinedTextField!
    
    @IBOutlet weak var phone: UnderlinedTextField!
    
    @IBOutlet weak var email: UnderlinedTextField!
    
    @IBOutlet weak var NaviBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.withImage(direction: .Left, image: UIImage(named: "user_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        phone.withImage(direction: .Left, image: UIImage(named: "phone_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        email.withImage(direction: .Left, image: UIImage(named: "email_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        
        //
        
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}
