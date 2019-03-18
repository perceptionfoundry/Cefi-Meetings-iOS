//
//  MainSettingsVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainSettingsVC: UIViewController {

    
    
    //  ******** OUTLET ************************

    @IBOutlet weak var NaviBar: UINavigationBar!
    
    
    
    
    
    //  ******** VIEWDIDLOAD ************************

    override func viewDidLoad() {
        super.viewDidLoad()

        NaviBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    
    
    
    
    
    
    //  ******** VIEWWILLAPPEAR ************************

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    
    
    //  *************** BACK BUTTON ACTION FUNCTION ************************

    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    
    // ****************** USER BUTTON ACTION ***************************

    
    @IBAction func userButtonAction(_ sender: Any) {
    }
    
    
    // ****************** PRIVACY BUTTON ACTION ***************************

    
    @IBAction func privacyButtonAction(_ sender: Any) {
    }
    
    
    
    // ****************** LOGOUT BUTTON ACTION ***************************

    
    @IBAction func logoutButtonAction(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "Auth")
        present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignIn") , animated: true, completion: nil)
    }
}
