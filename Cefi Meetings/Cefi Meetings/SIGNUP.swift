//
//  SIGNUP.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 13/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Alamofire

class SIGNUP: UIViewController {
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
        

        
        
        
    }
    

    @IBAction func doneAction(_ sender: Any) {
        
        let dic : [String : Any] = ["name":self.nameTF.text ?? "", "email" : self.emailTF.text ?? "", "phoneNumber":1, "password":self.passwordTf.text ?? ""] 
     
        
        
        Alamofire.request(apiLink, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: nil).responseJSON { (reponse) in
        }
        

        
        self.dismiss(animated: true, completion: nil)
    }
    
}
