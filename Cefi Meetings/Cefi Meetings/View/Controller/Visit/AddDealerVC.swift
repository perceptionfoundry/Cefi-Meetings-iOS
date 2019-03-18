//
//  AddDealerVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import HCSStarRatingView

class AddDealerVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dealerTF: UITextField!
  
    
    
    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let viewModel = AddDealerPersonViewModel()
    
    var dealerDele : DealerDelegate!
    var ContactDetail : Meeting?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dealerTF.delegate = self
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        
//        if dealerTF.text?.isEmpty == false && businessTF.text?.isEmpty == false{
//
//
//              dealerDele?.addDealer(DealerName: dealerTF.text!, BusinessName: businessTF.text!, Rating: ratingStar.value, ContractNumber: "")
//            self.dismiss(animated: true, completion: nil)
//
//        }
        
      
        
      self.addDetail()
        
        

    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.dismiss(animated: true, completion: nil)
        
        return true
    }
   
    
    func addDetail(){
        if dealerTF.text?.isEmpty == false {

        let apiLink = appGlobalVariable.apiBaseURL+"dealerperson/adddealerperson"
        
            let paramDict : [String : String] = [
            "userId":appGlobalVariable.userID,
            "dealerId":ContactDetail!.contactId!,
            "personName":dealerTF.text!
            
        ]
        

        
//        print(paramDict)
        
        viewModel.addPerson(API: apiLink, Param: paramDict) { (status, err) in
            
            if status == true{
                
                
                self.dealerDele?.addDealer(DealerName: self.dealerTF.text!)
                
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
