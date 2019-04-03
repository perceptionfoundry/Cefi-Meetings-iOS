//
//  userSettingVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class userSettingVC: UIViewController, UITextFieldDelegate {

    
    
    
    
    
    //  *************** OUTLET ************************

    @IBOutlet weak var userName: UnderlinedTextField!
    @IBOutlet weak var phone: UnderlinedTextField!
    @IBOutlet weak var email: UnderlinedTextField!
    @IBOutlet weak var NaviBar: UINavigationBar!
    @IBOutlet weak var editButton: Custom_Button!
    
    
    
    
    
    
    
    //************ Variable ******************
    
    var viewModel = UserSettingViewModel()
    var editViewModel = EditUserProfileViewModel()
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
    var editCheck = false
    

    
    //  *************** VIEWDIDLOAD ************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.delegate = self
        phone.delegate = self
        userName.isUserInteractionEnabled = false
        phone.isUserInteractionEnabled = false
        
        userName.withImage(direction: .Left, image: UIImage(named: "user_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        phone.withImage(direction: .Left, image: UIImage(named: "phone_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        email.withImage(direction: .Left, image: UIImage(named: "email_profile")!, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        
        //
        
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        
        let apilink = appGlobalVariable.apiBaseURL+"auth/user?\(appGlobalVariable.userID)"
        
        let paramDict = ["userId" : appGlobalVariable.userID]
        
        viewModel.fetchUserProfile(API: apilink, TextFields: paramDict) { (status, err, result) in
            
            
//            print(result)
            
            self.userName.text =  result.name!
            self.phone.text = String(result.phoneNumber!)
            self.email.text = result.email!
            
        }



    }
    
   
    
    
    
    
    //  *************** VIEWWILLAPPEAR ************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func editButtonAction(_ sender: Any) {
        
        print(editCheck)
        
       if editCheck == true {
            
        let alertVC = UIAlertController(title: "Alert", message: "Do you want to make changes?", preferredStyle: .actionSheet)
            let doneButton = UIAlertAction(title: "Confirm", style: .default) { (action) in
                self.editData()
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                
                self.editCheck = false
                self.navigationController?.popViewController(animated: true)
                
            }
            
            alertVC.addAction(doneButton)
            alertVC.addAction(cancelButton)
            
            self.present(alertVC, animated: true, completion: nil)
            
            
        }
        
       else{
        editCheck = true
        editButton.setTitle("Save", for: .normal)
        userName.isUserInteractionEnabled = true
        phone.isUserInteractionEnabled = true
        }
    }
    

    
    //  *************** BACK BUTTON ACTION FUNCTION ************************

    @IBAction func backButton(_ sender: Any) {
        
    
        self.navigationController?.popViewController(animated: true)
   
    
    }

    func editData(){
        
        

        let apilink = appGlobalVariable.apiBaseURL+"auth/user/update"
        
        let paramDict = ["userId" : appGlobalVariable.userID,
                         "name":userName.text!,
                         "email":email.text!,
                         "phoneNumber":phone.text!
        
        
        ]
        
        
        
        editViewModel.editUserProfile(API: apilink, TextFields: paramDict) { (status, err, result) in
            
            
            if status == true{
                self.navigationController?.popViewController(animated: true)

            }
            
        }

    }
    
    
}
