//
//  ProspectingVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 05/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl



class ProspectingVC: UIViewController {
    
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dealerContact: UILabel!
    @IBOutlet weak var dealerBusiness: UILabel!
    
    @IBOutlet weak var contractButtonView:UIView!
    @IBOutlet weak var followupButtonView:UIView!

    
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var meetingDate: UILabel!

    @IBOutlet weak var OutcomeSegment: TTSegmentedControl!
    @IBOutlet weak var businessSegment: TTSegmentedControl!
    @IBOutlet weak var EquipmentSegment: TTSegmentedControl!
    
    @IBOutlet weak var outcomeCommentTF: UITextView!
    
    
    
    let viewModel = MeetingReportViewModel()
    let getReportViewModel = GetVisitReportViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var meetingDetail : Meeting?
    
   
    
    var submitTitle = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        appGlobalVariable.startTime = Date()
        
        if meetingDetail?.visitStatus == "Completed"{
            scrollView.isUserInteractionEnabled = false
            submitButton.setTitle("Edit", for: .normal)
            self.submitTitle = "EDIT"
        }
//        print(meetingDetail)
        
        self.contractButtonView.isHidden = true
        self.followupButtonView.isHidden = true
        
        let dateString = meetingDetail!.addedDate!.split(separator: "T")
        
        
        dealerContact.text = meetingDetail!.contactName!
        dealerBusiness.text = meetingDetail!.businessName
        meetingTime.text = meetingDetail!.timeInString!
        meetingDate.text = String(dateString[0])
        
        
        
        OutcomeSegment.itemTitles = ["Positive","Neutral","Negative"]
        businessSegment.itemTitles = ["Decreased","Same","Increased"]
        EquipmentSegment.itemTitles = ["Yes", "Maybe", "No"]
        
        OutcomeSegment.allowChangeThumbWidth = false
        businessSegment.allowChangeThumbWidth = false
        EquipmentSegment.allowChangeThumbWidth = false
        
        EquipmentSegment.selectItemAt(index: 2)
        
        EquipmentSegment.didSelectItemWith = { (index, title) -> () in
                        print("Selected item \(index)")
            
            if self.EquipmentSegment.currentIndex == 2{
                self.contractButtonView.isHidden = true
                self.followupButtonView.isHidden = true

            }
                
            else{
                self.contractButtonView.isHidden = false
                self.followupButtonView.isHidden = false

            }
            
        }
        
        getInitialReport()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dealerList(){
        
        performSegue(withIdentifier: "Dealer_List", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Dealer", for: indexPath) as! DealerTableCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    @IBAction func setupFollowUpAction(_ sender: Any) {
        let storyboardRef =  UIStoryboard(name: "Visit", bundle: nil)
        
        let vc = storyboardRef.instantiateViewController(withIdentifier: "New_Visit") as! NewVisit
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        print(meetingDetail)
        
        vc.selectedContactName = meetingDetail!.contactName!
        vc.selectedContactID = meetingDetail!.contactId!
        vc.selectedPurpose = "Prospecting"
        vc.contractId = meetingDetail!.contractId!
        vc.selectedContractID = meetingDetail!.contractNumber ?? ""
        
    }
    
    @IBAction func startNewContractAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contract")
        self.navigationController?.pushViewController(vc, animated: true)
        
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
            var saleIndex = 0
            var equipmentIndex = 0
            
            
            if status == true{
                
                // Outcome
                let outComeValue = reportValue?.mainOutcome!
                
                
                switch  outComeValue{
                case "Positive":
                    outcomeIndex = 0
                case "Neutral":
                    outcomeIndex = 1
                case "Decrease":
                    outcomeIndex = 2
                default:
                    saleIndex = -1
                }
                
                self.OutcomeSegment.selectItemAt(index: outcomeIndex)

                // Outcome Comment
                
                self.outcomeCommentTF.text = result?.outcomeComments!
                
               // three month sale
                let saleValue = reportValue?.salesInLastThreeMonths!
                
                
                switch  saleValue{
                case "Decreased":
                    saleIndex = 0
                case "Same":
                    saleIndex = 1
                case "Increased":
                    saleIndex = 2
                default:
                    saleIndex = -1
                }
                
                    self.businessSegment.selectItemAt(index: saleIndex)
                
                
                // Equipment
                let equipmentValue = reportValue?.equipmentNeeds!
                
                
                switch  equipmentValue{
                case "Yes":
                    equipmentIndex = 0
                case "Maybe":
                    equipmentIndex = 1
                case "No":
                    equipmentIndex = 2
                default:
                    saleIndex = -1
                }
                
                self.EquipmentSegment.selectItemAt(index: outcomeIndex)

                
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
        
        let outcomeIndex = OutcomeSegment.currentIndex
        let businessIndex = businessSegment.currentIndex
        let equipmentIndex =  EquipmentSegment.currentIndex
        
        var outcomeValue = ""
        var businessValue = ""
        var equipmentValue =  ""
        
        switch outcomeIndex {
        case 0:
            outcomeValue = "Positive"
        case 1:
            outcomeValue = "Neutral"
        case 2:
            outcomeValue = "Negative"
        default:
            outcomeValue = ""
        }
        
        
        switch businessIndex {
        case 0:
            businessValue = "Deceased"
        case 1:
            businessValue = "Same"
        case 2:
            businessValue = "Increased"
        default:
            businessValue = ""
        }
        
        
        switch equipmentIndex {
        case 0:
            equipmentValue = "Yes"
        case 1:
            equipmentValue = "Maybe"
        case 2:
            equipmentValue = "No"
        default:
            equipmentValue = ""
        }
        
        
        
        
        
        let apilink = appGlobalVariable.apiBaseURL+"visitreport/addclientvisitreport"
        
        let paramDict : [String : String] = [
            "userId":appGlobalVariable.userID,
            "mainOutcome" : outcomeValue,
            "salesInLastThreeMonths": businessValue,
            "equipmentNeeds": equipmentValue,
            "visitId": meetingDetail!.id!,
            "outcomeComments": outcomeCommentTF.text!,
            "reportType": (meetingDetail?.purpose!)!,
            "reportStatus" : "Completed",
            "duration" : totalDuration!

            
        
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
