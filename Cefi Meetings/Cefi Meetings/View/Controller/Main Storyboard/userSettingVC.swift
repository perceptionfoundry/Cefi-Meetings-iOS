//
//  userSettingVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class userSettingVC: UIViewController {

    
    
    
    
    
    //  *************** OUTLET ************************

    @IBOutlet weak var userName: UnderlinedTextField!
    @IBOutlet weak var phone: UnderlinedTextField!
    @IBOutlet weak var email: UnderlinedTextField!
    @IBOutlet weak var NaviBar: UINavigationBar!
    
    
    
    
    
    
    
    //************ Variable ******************
    
    var viewModel = UserSettingViewModel()
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
    
    

    
    //  *************** VIEWDIDLOAD ************************

    override func viewDidLoad() {
        super.viewDidLoad()
        userName.withImage(direction: .Left, image: UIImage(named: "user_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        phone.withImage(direction: .Left, image: UIImage(named: "phone_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        email.withImage(direction: .Left, image: UIImage(named: "email_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        
        //
        
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        
        let apilink = appGlobalVariable.apiBaseURL+"auth/user?\(appGlobalVariable.userID)"
        
        let paramDict = ["userId" : "5c88f6d05a0c540017213210"]
        
        viewModel.fetchUserProfile(API: apilink, TextFields: paramDict) { (status, err, result) in
            
            
//            print(result)
        }



    }
    

    
    
    
    
    //  *************** VIEWWILLAPPEAR ************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    

    
    //  *************** BACK BUTTON ACTION FUNCTION ************************

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}
