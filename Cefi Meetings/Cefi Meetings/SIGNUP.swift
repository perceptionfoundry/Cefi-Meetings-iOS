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
        
        print("****************")
        print(self.apiLink)
        print("*****************")
        
        
        
    }
    

    @IBAction func doneAction(_ sender: Any) {
        
        var dic = ["name":self.nameTF.text ?? "", "email" : self.emailTF.text ?? "", "phoneNumber":1, "password":self.passwordTf.text ?? ""] as! [String : Any]
     
        
        
//        print(self.signUpDict)
        Alamofire.request(apiLink, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: nil).responseJSON { (reponse) in
            print("response = \(reponse.result.value)")
        }
        
//        Alamofire.request(apiLink,headers: self.signUpDict).responseJSON { (response) in
//            print(response)
//
//        }
//        Alamofire.request(apiLink, method: .post, parameters:[:], encoding: JSONEncoding.default, headers: self.signUpDict).responseJSON { (resp) in
////            print(resp)
//
//
//            do {
//            let json = try JSONSerialization.jsonObject(with: resp.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : Any]
//
//            print(json)
//
//            }
//            catch{
//                print("error")
//            }
//        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
