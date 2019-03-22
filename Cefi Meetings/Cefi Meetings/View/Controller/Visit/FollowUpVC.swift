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
    
    @IBOutlet weak var contractNumber: UILabel!
    @IBOutlet weak var visitorName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var OutcomeSegement: TTSegmentedControl!
    @IBOutlet weak var cancelSegment: TTSegmentedControl!
    
    @IBOutlet weak var pendingView: Custom_View!
    @IBOutlet weak var negativeView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var updateContractLabel: UILabel!
    @IBOutlet weak var setFollowUpLabel: UILabel!
    
    @IBOutlet weak var commentTF: UITextView!
    @IBOutlet weak var otherComment: UITextView!
    
    @IBOutlet weak var agreeSwitch: UISwitch!
    @IBOutlet weak var contractErrorSwitch: UISwitch!
    @IBOutlet weak var otherSwitch: UISwitch!
    
    @IBOutlet weak var buttonView_Y_constraint: NSLayoutConstraint!
    
    
    let reportViewModel = MeetingReportViewModel()
    let getContractViewModel = GetSpecificContractViewModel()
    let getReportViewModel = GetVisitReportViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var meetingDetail : Meeting?

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OutcomeSegement.allowChangeThumbWidth = false
        cancelSegment.allowChangeThumbWidth = false
        
        print(meetingDetail)
        
        
        let dateString = meetingDetail!.addedDate!.split(separator: "T")
        
//
      
        
        print(dateString)
       
        
        dealerContact.text = meetingDetail!.contactName!
        BusinessName.text = meetingDetail!.businessName
        meetingTime.text = meetingDetail!.timeInString
        meetingDate.text = String(dateString[0])
        contractNumber.text = meetingDetail!.contractNumber

        OutcomeSegement.didSelectItemWith = { (index, title) -> () in
//            print("Selected item \(index)")
            
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
//            print("Selected item \(index)")
            
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
        
        

        

        
        getInitialReport()

        
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    func getInitialReport(){
        
        var reportValue : MeetingReport?
        
        let apilink = appGlobalVariable.apiBaseURL+"visitreport/getclientvisitreport?visitId=\((meetingDetail!.id)!)&userId=\(appGlobalVariable.userID)"
        
        let paramDict = [
            "userId" : appGlobalVariable.userID,
            "visitId": meetingDetail!.id!
        ]
        
        print(apilink)
        print(paramDict)
        
        
        getReportViewModel.fetchVisitReport(API: apilink, TextFields: paramDict) { (status, Err, result) in
            
            reportValue = result
            var outcomeIndex = 0
            
            
            if status == true{
                
                
                //OUTCOME
                let outValue = reportValue?.mainOutcome!
                
                
                                switch  outValue{
                                case "Closed":
                                    outcomeIndex = 0
                                case "Positive":
                                    outcomeIndex = 1
                                case "Neutral":
                                    outcomeIndex = 2
                                case "Negative":
                                    outcomeIndex = 3
                                    self.pendingView.isHidden = true
                                    self.buttonView_Y_constraint.constant = 0
                                    self.negativeView.isHidden = false
                                default:
                                    outcomeIndex = -1
                                }
                
                                self.OutcomeSegement.selectItemAt(index: outcomeIndex)
                
                // OUTCOME COMMENT
                self.commentTF.text = result!.outcomeComments!
                //DID NOT AGREE

                let didAgreeStatus = result!.didNotAgreetoTerms!
                
                if didAgreeStatus{
                    self.agreeSwitch.setOn(true, animated: false)
                }
                else{
                    self.agreeSwitch.setOn(false, animated: false)

                }
                
                //CONTRACT ERROR
                let contractErrorstatus = result!.contractError!
                
                if contractErrorstatus{
                    self.contractErrorSwitch.setOn(true, animated: false)

                }
                else{
                    self.contractErrorSwitch.setOn(false, animated: false)

                }
                
                // OTHER
                let otherStatus = result!.other!
                
                if otherStatus{
                    self.otherSwitch.setOn(true, animated: false)

                }
                else{
                    self.otherSwitch.setOn(false, animated: false)

                }
                
                //OTHER COMMENT
                
                self.otherComment.text = result!.otherComments!
                
//
                
            }
        }
        
        
        
    }
    
    
    

    @IBAction func submitButtonAction(_ sender: Any) {
        
        let outcomeIndex = OutcomeSegement.currentIndex
       
        
        var outcomeValue = ""
//        var businessValue = ""
//        var equipment =  ""
        
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
         var paramDict = [String : Any]()
        
        
        if OutcomeSegement.currentIndex == 3{
            
             paramDict = [
                "userId":appGlobalVariable.userID,
                "mainOutcome" : outcomeValue,
                "outcomeComments": commentTF.text!,
                "visitId": meetingDetail!.id!,
                "reportType": (meetingDetail?.purpose!)!,
                "didNotAgreetoTerms": true,
                "contractError": true,
                "other": true,
                "otherComments": otherComment.text!,
  
                ]
        }
        
        else{
            paramDict = [
                "userId":appGlobalVariable.userID,
                "mainOutcome" : outcomeValue,
                "commentOnSales": commentTF.text!,
                "visitId": meetingDetail!.id!,
                "reportType": (meetingDetail?.purpose!)!
                
            ]
        }
        
        
        
        reportViewModel.addReport(API: apilink, Param: paramDict) { (status, err) in
            
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
  
    @IBAction func contractUpdateAction(_ sender: Any) {
        
        
        let apiLink = appGlobalVariable.apiBaseURL+"contracts/getspecificcontract"
        
        let paramDict : [String : String    ] = [
            "userId": appGlobalVariable.userID,
            "contractId":(meetingDetail?.contractId)!
            
        ]
        
        getContractViewModel.fetchSpecificContractDetail(API: apiLink, TextFields: paramDict) { (Status, err, result) in
            
            
            if Status == true{
            let value =  result
                print(value)

                self.performSegue(withIdentifier: "Contract_Segue", sender: value)

                
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination  as! ContractDetailsVC
        
        dest.userContract = sender as! Contract
    }
    
    
    @IBAction func followUpAction(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Visit", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Visit") as! NewVisit
                self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
        
        print(meetingDetail)
        
////        vc.purposeTF.text = meetingDetail!.purpose!
//        vc.contactTF.text = meetingDetail!.contactName!
//        vc.contractTF.text = meetingDetail!.contractId!
        vc.selectedContactName = meetingDetail!.contactName!
        vc.selectedContactID = meetingDetail!.contactId!
        vc.selectedPurpose = meetingDetail!.purpose!
        vc.contractId = meetingDetail!.contractId!
        vc.selectedContractID = meetingDetail!.contractNumber!
        
    }
    
    
    
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
