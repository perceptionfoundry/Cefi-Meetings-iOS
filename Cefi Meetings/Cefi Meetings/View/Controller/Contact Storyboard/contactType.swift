//
//  contactType.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 18/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class contactType: UIViewController {

   
    // ****************** OUTLET **********************

    @IBOutlet weak var leadSelected: UILabel!
    @IBOutlet weak var clientSelected: UILabel!
    @IBOutlet weak var dealerSelected: UILabel!
    @IBOutlet weak var prospectSelected: UILabel!
    
    // ****************** VARIABLE  **********************

    var previousSelected : String?
    var typeDelegate : typeDelegate?
    



    // ****************** VIEW DID LOAD  **********************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leadSelected.isHidden = true
        clientSelected.isHidden = true
        dealerSelected.isHidden = true
        
        guard let type = previousSelected else{return}
        
        if type == "Lead"{
            leadSelected.isHidden = false
            
        }
        else if type == "Client"{
            clientSelected.isHidden = false
            
            
        }
        else if type == "Dealer"{
            dealerSelected.isHidden = false
            
        }
     
        
    }
    
    
    
    
    // ******************  BACK BUTTON ACTION **********************

    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    // ****************** SELECTION BUTTON ACTION   **********************

    @IBAction func typeOptionButtonAction(_ sender: UIButton) {
        
        let buttonTag = sender.tag
        
        
//        print(buttonTag)
        
        if buttonTag == 0 {
            
            self.typeDelegate?.typeName(name: "Lead")
            self.navigationController?.popViewController(animated: true)
            
            
        }
        else if buttonTag == 1 {
            self.typeDelegate?.typeName(name: "Client")
            self.navigationController?.popViewController(animated: true)
        }
        else if buttonTag == 2 {
            self.typeDelegate?.typeName(name: "Dealer")
            self.navigationController?.popViewController(animated: true)
        }
      
        
        
    }

}
