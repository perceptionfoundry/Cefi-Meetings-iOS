//
//  ContractTypeVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 30/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class ContractTypeVC: UIViewController {

    
    @IBOutlet weak var DealSelected: UILabel!
    @IBOutlet weak var OpenSelected: UILabel!
    @IBOutlet weak var ClosedSelected: UILabel!
    
    
    
    var previousSelected : String?
    var typeDelegate : typeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DealSelected.isHidden = true
        OpenSelected.isHidden = true
        ClosedSelected.isHidden = true

        guard let type = previousSelected else{return}
        
        if type == "Deal"{
            DealSelected.isHidden = false

        }
        else if type == "Open"{
            OpenSelected.isHidden = false

            
        }
        else if type == "Closed"{
            ClosedSelected.isHidden = false

        }
       

    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func typeOptionButtonAction(_ sender: UIButton) {
        
    let buttonTag = sender.tag
        
        if buttonTag == 0 {
            
            self.typeDelegate?.typeName(name: "Deal")
            self.navigationController?.popViewController(animated: true)

            
        }
        else if buttonTag == 1 {
            self.typeDelegate?.typeName(name: "Open")
            self.navigationController?.popViewController(animated: true)
        }
        else if buttonTag == 2 {
            self.typeDelegate?.typeName(name: "Closed")
            self.navigationController?.popViewController(animated: true)
        }
       

        
    }
    
    
}
