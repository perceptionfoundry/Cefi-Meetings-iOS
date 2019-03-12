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
    
    @IBOutlet weak var businessSegment: TTSegmentedControl!
    
    @IBOutlet weak var EquipmentSegment: TTSegmentedControl!
    
    let viewModel = MeetingReportViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var meetingDetail : Meeting?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(meetingDetail)
        
        
        
        let dateString = meetingDetail!.addedDate!.split(separator: "T")
        
        let timeStampSplit = meetingDetail!.time!.split(separator: "T")
        let timeSplit  = timeStampSplit[1].split(separator: ":")
        let timeString = "\(timeSplit[0]):\(timeSplit[1]) "
        
     
        
        
        
        print(dateString)
        print(timeStampSplit)
     
        
        dealerContact.text = meetingDetail!.contactName!
        dealerBusiness.text = meetingDetail!.businessName
        meetingTime.text = timeString
        meetingDate.text = String(dateString[0])

        
        businessSegment.itemTitles = ["Deceased","Same","Increased"]
        EquipmentSegment.itemTitles = ["Yes", "Maybe", "No"]
        
        
        businessSegment.allowChangeThumbWidth = false
        EquipmentSegment.allowChangeThumbWidth = false
        
        
        
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
    
    
    @IBAction func submitButtonAction(_ sender: Any) {
        
        let businessIndex = businessSegment.currentIndex
        let equipmentIndex =  EquipmentSegment.currentIndex
        
        var outcomeValue = ""
        var businessValue = ""
        var equipment =  ""
        
       
        
        
        switch businessIndex {
        case 0:
            outcomeValue = "Deceased"
        case 1:
            outcomeValue = "Same"
        case 2:
            outcomeValue = "Increased"
        default:
            outcomeValue = ""
        }
        
        
        switch equipmentIndex {
        case 0:
            outcomeValue = "Yes"
        case 1:
            outcomeValue = "Maybe"
        case 2:
            outcomeValue = "No"
        default:
            outcomeValue = ""
        }
        
        
        
        
        
        let apilink = appGlobalVariable.apiBaseURL+"visitreport/addclientvisitreport"
        
        let paramDict : [String : String]   = [
            "userId": appGlobalVariable.userID,
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
