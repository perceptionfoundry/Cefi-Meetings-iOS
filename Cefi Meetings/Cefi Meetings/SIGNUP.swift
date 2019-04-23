//
//  SIGNUP.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 13/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Alamofire

class SIGNUP: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    

//    var signUpDict = [String:String]()
   
    var apiLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.apiLink = "\(appGlobalVariable.apiBaseURL)auth/register"
        

        emailTF.delegate = self
        
        
        
    }
    
    
    
    
    // ********** EMAIL VALIDATION *****************
    
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if emailTF.text?.count == 25{
            
            
            emailTF.endEditing(true)
            let alert = UIAlertController(title: "Alert", message: "You have entered INVALID email address", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        return true
    }
    
    
  
    

    @IBAction func doneAction(_ sender: Any) {
        
        if isValidEmail(emailID: self.emailTF.text!){
            
            
            print("valid")
            
            let dic : [String : Any] = ["name":self.nameTF.text ?? "", "email" : self.emailTF.text ?? "", "phoneNumber":1, "password":self.passwordTf.text ?? ""]
            
            
            
            Alamofire.request(apiLink, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: nil).responseJSON { (reponse) in
            }
            
            
            
            self.dismiss(animated: true, completion: nil)
        }
        
        else{
            let alert = UIAlertController(title: "Alert", message: "You have entered INVALID email address", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
