//
//  FollowUpVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 08/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl

class FollowUpVC: UIViewController {

    
    @IBOutlet weak var BusinessName: UILabel!
    
    @IBOutlet weak var visitorName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var OutcomeSegement: TTSegmentedControl!
    @IBOutlet weak var cancelSegment: TTSegmentedControl!
    
    @IBOutlet weak var pendingView: Custom_View!
    @IBOutlet weak var negativeView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    
 
    @IBOutlet weak var buttonView_Y_constraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OutcomeSegement.allowChangeThumbWidth = false
        cancelSegment.allowChangeThumbWidth = false
        
//        self.OutcomeSegement.thumbColor = UIColor(red: 0.942, green: 0.341, blue: 0.341, alpha: 1)

        OutcomeSegement.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            
            if self.OutcomeSegement.currentIndex == 3{
                self.OutcomeSegement.thumbColor = UIColor(red: 0.942, green: 0.341, blue: 0.341, alpha: 1)
                self.OutcomeSegement.thumbColor = UIColor.blue

                self.negativeView.isHidden = false
                self.pendingView.isHidden = true
                self.buttonView_Y_constraint.constant = 0
                
               
            }
                
            else{
                self.OutcomeSegement.thumbColor = UIColor(red: 0.255, green: 0.438, blue: 0.149, alpha: 1)
                self.negativeView.isHidden = true
                self.pendingView.isHidden = false
                self.buttonView_Y_constraint.constant = -200
                
                
            }
        }
     
        cancelSegment.didSelectItemWith = { (index, title) -> () in
            print("Selected item \(index)")
            
            if self.cancelSegment.currentIndex == 1{
                self.buttonsView.isHidden = true
            }
                
            else{
                self.buttonsView.isHidden = false
                
            }
          
        }
        
        
        buttonView_Y_constraint.constant = -200
        
        OutcomeSegement.itemTitles = ["Closed", "Positive", "Neutral","Negative"]
        cancelSegment.itemTitles = ["No","Yes"]
        
        
        negativeView.isHidden = true
        
        

        

        
       
        
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    

  
   
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
