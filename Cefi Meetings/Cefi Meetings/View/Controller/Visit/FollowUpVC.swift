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


protocol contractUpdate{
    func updating()
}


protocol meetingDate{
    func setDate(Date:String, apiResult : [String : Any])
}


class FollowUpVC: UIViewController, contractUpdate, meetingDate {
   
    
    func updating() {
        updateContractLabel.textColor = UIColor.white
        contractImage.image = (UIImage(named: "contract_white"))
        updateContractLabel.text = "Contract # \(meetingDetail!.contractNumber!)"
        updateContractVIew.backgroundColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
    }
    
    func setDate(Date: String , apiResult : [String : Any]) {
        
        setFollowUpLabel.textColor = UIColor.white
        setFollowUpLabel.text! = Date
        followUpImage.image = (UIImage(named: "followUP_white"))
        followUpView.backgroundColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
        
        self.newFollowUp = apiResult
    }
    

    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
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
    
    @IBOutlet weak var followUpView: Custom_View!
    @IBOutlet weak var updateContractVIew: Custom_View!
    
    @IBOutlet weak var contractButton: UIButton!
    @IBOutlet weak var followUpButton: UIButton!
    
    @IBOutlet weak var contractImage: UIImageView!
    @IBOutlet weak var followUpImage: UIImageView!
    
    @IBOutlet weak var buttonView_Y_constraint: NSLayoutConstraint!
    
    
    
    
    let reportViewModel = MeetingReportViewModel()
    let getContractViewModel = GetSpecificContractViewModel()
    let getReportViewModel = GetVisitReportViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var meetingDetail : Meeting?

    var newFollowUp = [String : Any]()
    
    var submitTitle = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Start meeting time
        
        self.appGlobalVariable.startTime = Date()
        
        
        
        
        
        
        
        
        if meetingDetail?.visitStatus == "Completed"{
            scrollView.isUserInteractionEnabled = false
            submitButton.setTitle("Edit", for: .normal)
            self.submitTitle = "EDIT"
        }
        
        
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
            
            
            if self.OutcomeSegement.currentIndex == 2{
//
                
            self.pendingView.isHidden = true
                self.negativeView.isHidden = true

            self.buttonView_Y_constraint.constant = -400
                
                
            }
            
           else if self.OutcomeSegement.currentIndex == 3{
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
            
            print(reportValue)
            if status == true{
                
                
                //OUTCOME
                let outValue = reportValue?.mainOutcome!
                
                print(outValue!)
         
                
                                switch  outValue!{
                                case "Closed":
                                    self.OutcomeSegement.selectItemAt(index: 0, animated: true)

//                                    outcomeIndex = 0
                                case "Positive":
                                    self.OutcomeSegement.selectItemAt(index: 1, animated: true)

//                                    outcomeIndex = 1
                                case "Neutral":
                                    self.OutcomeSegement.selectItemAt(index: 2, animated: true)

//                                    outcomeIndex = 2
                                    self.pendingView.isHidden = true
                                    self.negativeView.isHidden = true
                                    self.buttonView_Y_constraint.constant = -400
                                    
                                case "Negative":
                                    self.OutcomeSegement.selectItemAt(index: 3, animated: true)

//                                    outcomeIndex = 3
                                    self.pendingView.isHidden = true
                                    self.buttonView_Y_constraint.constant = 0
                                    self.negativeView.isHidden = false
                                default:
                                    outcomeIndex = -1
                                }
                print(outcomeIndex)
//                                self.OutcomeSegement.selectItemAt(index: outcomeIndex, animated: true)
                
                // OUTCOME COMMENT
                self.commentTF.text = result!.outcomeComments ?? ""
                //DID NOT AGREE

                let didAgreeStatus = result!.didNotAgreetoTerms!
                
                if didAgreeStatus{
                    self.agreeSwitch.setOn(true, animated: true)
                }
                else{
                    self.agreeSwitch.setOn(false, animated: true)

                }
                
                //CONTRACT ERROR
                let contractErrorstatus = result!.contractError!
                
                if contractErrorstatus{
                    self.contractErrorSwitch.setOn(true, animated: true)

                }
                else{
                    self.contractErrorSwitch.setOn(false, animated: true)

                }
                
                // OTHER
                let otherStatus = result!.other!
                
                if otherStatus{
                    self.otherSwitch.setOn(true, animated: true)

                }
                else{
                    self.otherSwitch.setOn(false, animated: true)

                }
                
                //OTHER COMMENT
                
                self.otherComment.text = result!.otherComments!
                
//
                
            }
        }
        
        
        
    }
    
    
    

    @IBAction func submitButtonAction(_ sender: Any) {
        
        
        let endTime = Date()
        
    
        let totalDuration = getTimeComponentString(olderDate: self.appGlobalVariable.startTime!, newerDate: endTime)
        
        
        
        
       
        if submitTitle == "EDIT"{
            
            scrollView.isUserInteractionEnabled = true
            submitButton.setTitle("Submit", for: .normal)
            submitTitle = ""
        }
            
        else{
        
        
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
                "didNotAgreetoTerms": String(agreeSwitch.isOn),
                "contractError": String(contractErrorSwitch.isOn),
                "other": String(otherSwitch.isOn),
                "otherComments": otherComment.text!,
                "reportStatus" : "Completed",
                "followUpVisitId" : newFollowUp["_id"] as! String,
             "followUpVisitTime" : newFollowUp["dateInString"] as! String,
             "duration" : totalDuration!

  
                ]
        }
        
        else{
            paramDict = [
                "userId":appGlobalVariable.userID,
                "mainOutcome" : outcomeValue,
                "commentOnSales": commentTF.text!,
                "visitId": meetingDetail!.id!,
                "reportType": (meetingDetail?.purpose!)!,
                "reportStatus" : "Completed",
                "didNotAgreetoTerms": "false",
                "contractError": "false",
                "other": "false",
                "otherComments": "",
                "followUpVisitId" : newFollowUp["_id"] as! String,
                "followUpVisitTime" : newFollowUp["dateInString"] as! String,
                "duration" : totalDuration!

                
            ]
        }
        
            
            
            print(paramDict)
        
        
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
        dest.segueStatus = true
        dest.contractValue = self
    }
    
    
    @IBAction func followUpAction(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Visit", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Visit") as! NewVisit
        
        vc.segueStatus = true
        vc.dateValue = self
                self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
        
//        print(meetingDetail)
        

        vc.selectedContactName = meetingDetail!.contactName!
        vc.selectedContactID = meetingDetail!.contactId!
        vc.selectedPurpose = meetingDetail!.purpose!
        vc.contractId = meetingDetail!.contractId!
        vc.selectedContractID = meetingDetail!.contractNumber!
        
    }
    
    
    
    func getTimeComponentString(olderDate older: Date,newerDate newer: Date) -> (String?)  {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        
        let componentsLeftTime = Calendar.current.dateComponents([.minute , .hour , .day,.month, .weekOfMonth,.year], from: older, to: newer)
        
        let year = componentsLeftTime.year ?? 0
        if  year > 0 {
            formatter.allowedUnits = [.year]
            return formatter.string(from: older, to: newer)
        }
        
        
        let month = componentsLeftTime.month ?? 0
        if  month > 0 {
            formatter.allowedUnits = [.month]
            return formatter.string(from: older, to: newer)
        }
        
        let weekOfMonth = componentsLeftTime.weekOfMonth ?? 0
        if  weekOfMonth > 0 {
            formatter.allowedUnits = [.weekOfMonth]
            return formatter.string(from: older, to: newer)
        }
        
        let day = componentsLeftTime.day ?? 0
        if  day > 0 {
            formatter.allowedUnits = [.day]
            return formatter.string(from: older, to: newer)
        }
        
        let hour = componentsLeftTime.hour ?? 0
        if  hour > 0 {
            formatter.allowedUnits = [.hour]
            return formatter.string(from: older, to: newer)
        }
        
        let minute = componentsLeftTime.minute ?? 0
        if  minute > 0 {
            formatter.allowedUnits = [.minute]
            return formatter.string(from: older, to: newer) ?? ""
        }
        
        return nil
    }
    
    
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
