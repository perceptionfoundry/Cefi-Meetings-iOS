//
//  AddDealerVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class AddDealerVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dealerTF: UITextField!
    
    
    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let viewModel = AddDealerPersonViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        let apiLink = appGlobalVariable.apiBaseURL
        
        let paramDict = [
            "userId":appGlobalVariable.userID,
            "dealerId":"5c61817b3e2919343fd52c96",
            "personName":"Hunnain Pasha"
            
        ]
        
        viewModel.addPerson(API: apiLink, Param: paramDict) { (status, err) in
            
            if status == true{
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
