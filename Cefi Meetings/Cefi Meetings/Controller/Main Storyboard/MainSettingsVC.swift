//
//  MainSettingsVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainSettingsVC: UIViewController {

    
    
    
    @IBOutlet weak var NaviBar: UINavigationBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NaviBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func userButtonAction(_ sender: Any) {
    }
    
    @IBAction func privacyButtonAction(_ sender: Any) {
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
    }
}
