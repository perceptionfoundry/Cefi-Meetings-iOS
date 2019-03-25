//
//  EmailVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit


class EmailVC: UIViewController {

    
    
    @IBOutlet weak var emailTF: UITextField!
    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    var viewModel = EmailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        
        // parameter that are required by API
        
       
        
        
        
        //   Verifying both textfield is not left empty
        if emailTF.text?.isEmpty == false {
            
            let apilink = appGlobalVariable.apiBaseURL+"forgetpassword"
            
            let paramDict = [
                "email" : emailTF.text  ,
                
                ] as [String : Any]
            
            
            
            
            //  Hitting ApiLink with required parameter
            
            viewModel.ForgetEmail(API: apilink, Textfields: paramDict) { (status, message) in
            
                print(message)
                print(status)
                
                if status == false{
                    
                    self.alertMessage(Title: "Forget Password Error", Message: message!)
                }
                    
                    
                    
                else{
                    
                  
                    
                    let alert = UIAlertController(title: "Alert", message: message!, preferredStyle: .alert)
                    let dismissButton = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.performSegue(withIdentifier: "Verify_Segue", sender: nil)

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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination  as! NewPasswordVC
        
        dest.emailAddress = emailTF.text!
    }
    
// ******* ALERT VIEWCONTROLLER ************



func alertMessage(Title : String, Message : String ){
    
    let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
    let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
    
    alertVC.addAction(dismissButton)
    self.present(alertVC, animated: true, completion: nil)
}
}
