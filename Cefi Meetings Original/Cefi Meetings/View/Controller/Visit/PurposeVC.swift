//
//  PurposeVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit


protocol PurposeDelegate{
    func purposeValue(value : String)
}

class PurposeVC: UIViewController {

    @IBOutlet weak var prospectingSelected: UILabel!
    @IBOutlet weak var followUpSelected: UILabel!
   
    
    
    
    var previousSelected : String?
    var purposeDelegate : PurposeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prospectingSelected.isHidden = true
        followUpSelected.isHidden = true
       
        
        guard let purpose = previousSelected else{return}
        
        if purpose == "Prospecting"{
            prospectingSelected.isHidden = false
            
        }
        else if purpose == "Follow UP"{
            followUpSelected.isHidden = false
            
            
        }
      
        
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func typeOptionButtonAction(_ sender: UIButton) {
        
        let buttonTag = sender.tag
        
        if buttonTag == 0 {
            
            self.purposeDelegate?.purposeValue(value: "Prospecting")
            self.navigationController?.popViewController(animated: true)
            
            
        }
        else if buttonTag == 1 {
            self.purposeDelegate?.purposeValue(value: "Follow Up")
            self.navigationController?.popViewController(animated: true)
        }
     
        
        
    }
    

}
