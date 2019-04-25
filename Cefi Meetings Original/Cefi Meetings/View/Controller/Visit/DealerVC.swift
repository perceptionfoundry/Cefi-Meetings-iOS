//
//  DealerVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl

//************** Protocol Define ***************

protocol DealerDelegate{

    func selectedDealer(DealerName : String)
}

protocol NewLeadDelegate {
    func leadDetail(contactName:String?, businessName:String?, ContractNumber:String, Rating: CGFloat?)
}







class DealerVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DealerDelegate, NewLeadDelegate{
    
    
    
    
    func leadDetail(contactName: String?, businessName: String?, ContractNumber: String, Rating: CGFloat?) {
        
        
        self.NewContact.append(newAddition(newContactName: contactName!, newBusinessName: businessName!, newContractNumber: ContractNumber, newRating: Rating!))
        
        dealerTable.reloadData()
    }
    
    func addDealer(DealerName: String) {
    
        
    }
    
    func selectedDealer(DealerName: String) {
        dealerContact.text = DealerName
    }
    

   
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dealerTable: UITableView!
    @IBOutlet weak var dealerContact: UILabel!
    @IBOutlet weak var dealerName: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var contractButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    @IBOutlet weak var dealerBusiness: UILabel!
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var meetingDate: UILabel!
    
    @IBOutlet weak var saleStatus: TTSegmentedControl!
    
    @IBOutlet weak var newLead: TTSegmentedControl!
    
    
    
    let updateReportViewModel = MeetingReportViewModel()
    let getReportViewModel = GetVisitReportViewModel()

    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var meetingDetail : Meeting?

    struct newAddition{
       var newContactName: String?
       var newBusinessName: String?
       var newContractNumber: String
       var newRating: CGFloat?
    }
    
    
    var NewContact = [newAddition]()
    
    var submitTitle = ""
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

//        print(meetingDetail)
        
      
        if self.meetingDetail?.visitStatus == "Completed"{
            self.scrollView.isUserInteractionEnabled = false
            self.submitButton.setTitle("Edit", for: .normal)
            self.submitTitle = "EDIT"
        }
        
        
        newLead.selectItemAt(index: 1, animated: true)
        dealerTable.isHidden = true
        bottomView.isHidden = true
        
        let dateString = meetingDetail!.addedDate!.split(separator: "T")
        dealerName.text = meetingDetail!.contactName!
        dealerBusiness.text = meetingDetail!.businessName
//        meetingTime.text = timeString
        meetingTime.text = meetingDetail!.timeInString
        meetingDate.text = String(dateString[0])
        
        saleStatus.allowChangeThumbWidth = false
        newLead.allowChangeThumbWidth = false
        
        saleStatus.itemTitles = ["Increased","Same","Decreased"]
        newLead.itemTitles = ["Yes", "No"]
        dealerTable.delegate = self
        dealerTable.dataSource = self
        
        
        let contactTap = UITapGestureRecognizer(target: self, action: #selector(dealerList))
        dealerContact.addGestureRecognizer(contactTap)
        
        
        
        newLead.didSelectItemWith = { (index, title) -> () in
//            print("Selected item \(index)")
            
            if self.newLead.currentIndex == 0{
              
                self.bottomView.isHidden = false
                
            }
            else{
                
                self.bottomView.isHidden = true
                
                
            }
        }
        dealerTable.reloadData()
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
            
            print(reportValue)
            
            
            var saleIndex = 0
            if status == true{
                
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
                
                self.saleStatus.selectItemAt(index: saleIndex, animated: true)
                
               
            }
        }
        
    
        
    }
    
    @objc func dealerList(){
        
        performSegue(withIdentifier: "Dealer_List", sender: nil)
        
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination  as! DealerListVC
        
        dest.delegateDealer = self
        dest.ContactDetail = meetingDetail!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewContact.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Dealer", for: indexPath) as! DealerTableCell
        
        cell.DealerName.text = NewContact[indexPath.row].newContactName!
        cell.businessName.text = NewContact[indexPath.row].newBusinessName!
        cell.contractNumber.text = NewContact[indexPath.row].newContractNumber
        cell.ratingStar.value = NewContact[indexPath.row].newRating!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    
    
    
    
    @IBAction func addContactAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contact") as! NewContactVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.referrredName = (meetingDetail?.contactName)!
        vc.referredID = meetingDetail?.contactId
        

    }
    
    
    
    
    
    
    
    @IBAction func startNewContractAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contract") as! NewContractVC
        self.navigationController?.pushViewController(vc, animated: true)
        dealerTable.isHidden = false
        
        vc.LeadDelegate = self
        vc.leadFlag = true

    }
    

    
    @IBAction func submitButtonAction(_ sender: Any) {
        
        if submitTitle == "EDIT"{
        
            scrollView.isUserInteractionEnabled = true
            submitButton.setTitle("Submit", for: .normal)
            submitTitle = ""
    }
        
        else{
        
        let saleIndex = saleStatus.currentIndex
        
        
        var saleValue = ""
        
       
        
        
        
        
        
        
        switch  saleIndex{
        case 0:
            saleValue = "Deceased"
        case 1:
            saleValue = "Same"
        case 2:
            saleValue = "Increased"
        default:
            saleValue = ""
        }
        
        
       
        
        
        
        
        
        let apilink = appGlobalVariable.apiBaseURL+"visitreport/addclientvisitreport"
        
        let paramDict : [String : String]   = [
            "userId":appGlobalVariable.userID,
            "visitId": meetingDetail!.id!,
            "salesInLastThreeMonths": saleValue,
            "dealerPersonName" : dealerName.text!,
            "reportType": (meetingDetail?.purpose!)!,
            "reportStatus" : "Completed"
            
            
        ]
        
        updateReportViewModel.addReport(API: apilink, Param: paramDict) { (status, err) in
            
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
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
