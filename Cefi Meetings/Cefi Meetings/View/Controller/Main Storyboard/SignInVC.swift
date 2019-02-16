//
//  ViewController.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 24/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Alamofire

class SignInVC: UIViewController {
    
    // ****************** OUTLET *****************
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    //******************************
    
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var apiLink = ""
    
    var viewModel = SignInViewModel()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiLink = "\(appGlobalVariable.apiBaseURL)auth/login"
        
        viewModel.testME()
    }

    
    

    
    @IBAction func loginButtonAction(_ sender: Any) {
       
     
        // ********* parameter that are required by API ************
        let signInParameter = [
            "email" : userNameTF?.text ?? "" ,
            "password" : passwordTF?.text ?? ""
            
            ] as [String : Any]
        
        
        
      
        
        
        
        
        //  *************** Verifying both textfield is not left empty ***********
        if userNameTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false{
            
            
            
            
            // ****** Hitting ApiLink with required parameter **********

            viewModel.signINProcess(API: self.apiLink, Textfields: signInParameter) { (status, err) in
                
               
                
                if status == false{
                    
                    self.alertMessage(Title: "Sign In Error", Message: err!)
                }
                    
                    
                
                else{
                    self.performSegue(withIdentifier: "Dashboard", sender: nil)
                    }
                
                
            }

        }
        
        else{
            self.alertMessage(Title: "TextField Empty", Message: "Some of textfield is left empty")
        }
        
    }
    
    
    
    // ******* Function that will handle Alert Viewcontroller ************
    
    
    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
}



