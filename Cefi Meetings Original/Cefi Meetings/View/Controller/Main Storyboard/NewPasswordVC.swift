//
//  NewPasswordVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class NewPasswordVC: UIViewController {

    
    
    @IBOutlet weak var verificationTF: UITextField!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    
    
    var emailAddress = ""
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate

    var viewModel = NewPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        
        // parameter that are required by API
        
        
        
        
        
        //   Verifying both textfield is not left empty
        if verificationTF.text?.isEmpty == false && newPasswordTF.text?.isEmpty == false {
            
            let apilink = appGlobalVariable.apiBaseURL+"forgetpassword/verify"
            
            let paramDict = [
                "email":emailAddress,
                "code":verificationTF.text!,
                "password":newPasswordTF.text!
                
                ] as [String : Any]
            
            
            
            
            //  Hitting ApiLink with required parameter
            
            viewModel.newPassword(API: apilink, Textfields: paramDict) { (status, message) in
                
                print(message)
                print(status)
                
                if status == false{
                    
                    self.alertMessage(Title: "Forget Password Error", Message: message!)
                }
                    
                    
                    
                else{
                    
                    
                    
                    let alert = UIAlertController(title: "Alert", message: message!, preferredStyle: .alert)
                    let dismissButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
  self.present(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignIn") , animated: true, completion: nil)
                    })
                    
                    alert.addAction(dismissButton)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
                
                
            }
            
        }
            
        else{
            self.alertMessage(Title: "TextField Empty", Message: "Some of textfield is left empty")
        }
        
    }
    // ******* ALERT VIEWCONTROLLER ************
    
    
    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }

}
