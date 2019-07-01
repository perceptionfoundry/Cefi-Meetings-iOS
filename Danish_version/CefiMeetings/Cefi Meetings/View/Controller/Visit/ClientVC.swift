//
//  ClientVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 05/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl



class ClientVC: UIViewController {
    
    
    @IBOutlet weak var dealerContact: UILabel!
    @IBOutlet weak var dealerBusiness: UILabel!
    
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var meetingDate: UILabel!
    
    @IBOutlet weak var threeMonthSaleSegment: TTSegmentedControl!
    
    @IBOutlet weak var newLeadSegment: TTSegmentedControl!
    
    let viewModel = MeetingReportViewModel()
    let getReportViewModel = GetVisitReportViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var meetingDetail : Meeting?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let dateString = meetingDetail!.addedDate!.split(separator: "T")
        

     
        
        dealerContact.text = meetingDetail!.contactName!
        dealerBusiness.text = meetingDetail!.businessName
        meetingTime.text = meetingDetail!.timeInString!
        meetingDate.text = String(dateString[0])

        
        threeMonthSaleSegment.itemTitles = ["Deceased","Same","Increased"]
        newLeadSegment.itemTitles = ["Yes", "Maybe", "No"]
        
        
        threeMonthSaleSegment.allowChangeThumbWidth = false
        newLeadSegment.allowChangeThumbWidth = false
        
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
    
    @IBAction func addContactAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contact")
        self.navigationController?.pushViewController(vc, animated: true)
        
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
            var saleIndex = 0
            if status == true{
                
                let saleValue = reportValue?.salesInLastThreeMonths!
                
                
                switch  saleValue{
                case "Deceased":
                    saleIndex = 0
                case "Same":
                    saleIndex = 1
                case "Increased":
                    saleIndex = 2
                default:
                    saleIndex = -1
                }
                
                self.threeMonthSaleSegment.selectItemAt(index: saleIndex, animated: true)
                
            }
        }
        
        
        
    }
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        
        let businessIndex = threeMonthSaleSegment.currentIndex
        let equipmentIndex =  newLeadSegment.currentIndex
        
        var outcomeValue = ""
        var businessValue = ""
        var equipmentValue =  ""
        
       
        
        
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
        
        let paramDict : [String : String]   = [
            "userId":appGlobalVariable.userID,
            "salesInLastThreeMonths": businessValue,
            "equipmentNeeds": equipmentValue,
            "visitId": meetingDetail!.id!,
            "reportType": (meetingDetail?.purpose!)!
            
            
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
