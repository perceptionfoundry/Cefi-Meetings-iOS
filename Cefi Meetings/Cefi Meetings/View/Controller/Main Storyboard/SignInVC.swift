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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiLink = "\(appGlobalVariable.apiBaseURL)auth/login"


    }

    @IBAction func loginButtonAction(_ sender: Any) {
       
        print("************")
        print(self.apiLink)
        print("************")
        
        let signInParameter = [
            "email" : userNameTF?.text ?? "" ,
            "password" : passwordTF?.text ?? ""
            
        ] as! [String : Any]
        if userNameTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false{
            
            // ****** Hitting ApiLink with required parameter **********

            Alamofire.request(apiLink, method: .post, parameters: signInParameter, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                
                var value = response.result.value  as! [String : Any]
                
                print("key = \(value.keys)")
                print("value = \(value.values)")
                
                let check  = value["success"] as? Double
                
                if check == 0 {
                    
                    
                    print("here")
                    
                    let errorValue =  value["errors"] as! [String : String]
                    //                print("error:\(message.values.first!)")
                    
                    
                    let errMessage = errorValue.values.first!
                    
                    self.alertMessage(Title: "SignIn Error", Message: errMessage)
                    
                    
                    
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
    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
}

