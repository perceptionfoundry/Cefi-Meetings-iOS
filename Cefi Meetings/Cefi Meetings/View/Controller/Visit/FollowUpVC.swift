//
//  FollowUpVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 08/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl
import HCSStarRatingView

class FollowUpVC: UIViewController {

    @IBOutlet weak var dealerContact: UILabel!
    @IBOutlet weak var BusinessName: UILabel!

    
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var meetingDate: UILabel!
    
    @IBOutlet weak var ratingStar: HCSStarRatingView!
    
    @IBOutlet weak var visitorName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var OutcomeSegement: TTSegmentedControl!
    @IBOutlet weak var cancelSegment: TTSegmentedControl!
    
    @IBOutlet weak var pendingView: Custom_View!
    @IBOutlet weak var negativeView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var commentTF: UITextView!
    
 
    @IBOutlet weak var buttonView_Y_constraint: NSLayoutConstraint!
    
    
    let viewModel = MeetingReportViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var meetingDetail : Meeting?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OutcomeSegement.allowChangeThumbWidth = false
        cancelSegment.allowChangeThumbWidth = false
        
        print(meetingDetail)
        
        
        let dateString = meetingDetail!.addedDate!.split(separator: "T")
        
        let timeStampSplit = meetingDetail!.time!.split(separator: "T")
        let timeSplit  = timeStampSplit[1].split(separator: ":")
        let timeString = "\(timeSplit[0]):\(timeSplit[1]) "
        
      
        
        print(dateString)
        print(timeStampSplit)
       
        
        dealerContact.text = meetingDetail!.contactName!
        BusinessName.text = meetingDetail!.businessName
        meetingTime.text = timeString
        meetingDate.text = String(dateString[0])
        

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
    

    @IBAction func submitButtonAction(_ sender: Any) {
        
        let outcomeIndex = OutcomeSegement.currentIndex
       
        
        var outcomeValue = ""
        var businessValue = ""
        var equipment =  ""
        
        switch outcomeIndex {
        case 0 :
            outcomeValue = "Closed"
        case 1:
            outcomeValue = "Positive"
        case 2:
            outcomeValue = "Neutral"
        case 3:
            outcomeValue = "Negative"
        default:
            outcomeValue = ""
        }
        
        
       
        
        
        
        
        
        let apilink = appGlobalVariable.apiBaseURL+"visitreport/addclientvisitreport"
        
        let paramDict : [String : String]   = [
            "userId":appGlobalVariable.userID,
            "salesInLastThreeMonths": outcomeValue,
            "visitId": meetingDetail!.id!,
            
            
        ]
        
        viewModel.addReport(API: apilink, Param: paramDict) { (status, err) in
            
            if status == true{
                self.navigationController?.popViewController(animated: true)
            }
                
            else{
                let alert  = UIAlertController(title: "Server Error", message: err!, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
  
   
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
