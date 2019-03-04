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
    
    
    
    
    
    // ******************* VARIABLE ***************************

    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var apiLink = ""
    
    var viewModel = SignInViewModel()
    
    
    
    
    
    
    // ******************* VIEWDIDLOAD ***************************

    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiLink = "\(appGlobalVariable.apiBaseURL)auth/login"
        
        
//        self.performSegue(withIdentifier: "Dashboard", sender: nil)

        
        if UserDefaults.standard.bool(forKey: "Auth") == true{
            
            
            appGlobalVariable.userID = UserDefaults.standard.string(forKey: "UserID")!
            
            print(appGlobalVariable.userID)
            
            self.authSegue()
//
            
            

        }
        
    }

   
    func authSegue(){
//        self.performSegue(withIdentifier: "Dashboard", sender: nil)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Dashboard")
        self.navigationController?.pushViewController(vc, animated: false)
        
        
        
    }
    

    // ******************* LOGIN BUTTON ACTION ***************************

    @IBAction func loginButtonAction(_ sender: Any) {
       
     
        // parameter that are required by API
        
        let signInParameter = [
            "email" : userNameTF?.text ?? "" ,
            "password" : passwordTF?.text ?? ""

            ] as [String : Any]
        
        

        //   Verifying both textfield is not left empty
        if userNameTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false{
            
            
            
            
            //  Hitting ApiLink with required parameter 

            viewModel.signINProcess(API: self.apiLink, Textfields: signInParameter) { (status, err) in
                
               
                
                if status == false{
                    
                    self.alertMessage(Title: "Sign In Error", Message: err!)
                }
                    
                    
                
                else{
                    
                    self.appGlobalVariable.userID = err!
                    
                    print(self.appGlobalVariable.userID)
                    
                    //
                    UserDefaults.standard.set(true, forKey: "Auth")
                    UserDefaults.standard.set(err!, forKey: "UserID")
                    
                    //
                    
                    self.performSegue(withIdentifier: "Dashboard", sender: nil)
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



