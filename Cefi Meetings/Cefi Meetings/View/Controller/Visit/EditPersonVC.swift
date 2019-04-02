//
//  EditPersonVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 01/04/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import HCSStarRatingView




class EditPersonVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dealerTF: UITextField!
    
    
    
    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let viewModel = EditDealerPersonViewModel()
    
    var dealerDele : addPersonDelegate!
    var ContactDetail : Meeting?
    var personID = ""
    var personName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dealerTF.text = personName
        dealerTF.delegate = self
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        
        
        
        
        
        self.addDetail()
        
        
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.dismiss(animated: true, completion: nil)
        
        return true
    }
    
    
    func addDetail(){
        if dealerTF.text?.isEmpty == false {
            
            let apiLink = appGlobalVariable.apiBaseURL+"dealerperson/updatedealerperson"
            
            let paramDict : [String : String] = [
                "userId":appGlobalVariable.userID,
                "personId":self.personID,
                "personName":dealerTF.text!

                
            ]
            
            
            
                    print(paramDict)
            
            viewModel.addPerson(API: apiLink, Param: paramDict) { (status, err) in
                
                if status == true{
                    
                    
                    self.dealerDele?.personlistReload()
                    
                    self.dismiss(animated: true, completion: nil)
                }
                    
                else{
                    let alert  = UIAlertController(title: "Server Error", message: err!, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
}

