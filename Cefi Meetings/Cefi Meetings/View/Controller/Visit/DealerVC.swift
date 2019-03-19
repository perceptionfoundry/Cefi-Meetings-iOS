//
//  DealerVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl



protocol DealerDelegate{

    func selectedDealer(DealerName : String)
}



class DealerVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DealerDelegate{
    func addDealer(DealerName: String) {
    
        
    }
    
    func selectedDealer(DealerName: String) {
        dealerContact.text = DealerName
    }
    

    
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

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(meetingDetail)
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
        
        saleStatus.itemTitles = ["Increased","Same","Deceased"]
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
    
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        
        
        
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
            "reportType": (meetingDetail?.purpose!)!
            
            
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
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
