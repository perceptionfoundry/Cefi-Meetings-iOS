//
//  MainPendingVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainPendingVC: UIViewController, UITableViewDataSource,UITableViewDelegate {

    
    // ****************** OUTLET ***************************

    @IBOutlet weak var pendingQuantity: UILabel!
    @IBOutlet weak var pending_Table: UITableView!
    
    
    
    
    
    
    
    // ******************** VARIABLE *************************
    var appGlobalVariable = UIApplication.shared.delegate  as! AppDelegate
    var pendingContent = [Pending]()
    var viewModel = PendingDocumentViewModel()
    var getContractViewModel = GetSpecificContractViewModel()
    
    
    
    
    // ****************** VIEWDIDLOAD ***************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pending_Table.delegate = self
        pending_Table.dataSource = self
        
        pending_Table.reloadData()
        
//    self.getPending()
    }
    
    
    
    
    
    
    
    // ****************** VIEWWILLAPPEAR ***************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        pending_Table.isUserInteractionEnabled = true
        pending_Table.tableFooterView = UIView()
        self.getPending()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    
    // ****************** VIEWMODEL FUNCTION ***************************

    func getPending(){
        
        
        
       
        
        
        let apiLink  = appGlobalVariable.apiBaseURL+"contracts/getpendingdocs?userId=\(appGlobalVariable.userID)"
        
        let paramKey : [String : String] = ["userId": appGlobalVariable.userID,
                                         
        ]
        
//        print(paramKey)
        
        viewModel.fetchPendingDocument(API: apiLink, TextFields: paramKey) { (status, err, Result) in
            
            
        

            if status == true{
                self.pendingContent.removeAll()

                self.pendingContent = Result
                
                var totalReminder = 0
                
                for loop in self.pendingContent{
                    
                    totalReminder += loop.allPendingDocumentCounts!
                    self.pendingQuantity.text = "\(totalReminder) pending documents"

                }
                
                
                
                self.pending_Table.reloadData()
                
            }
        }
        
    }
    
    
    
    
    
    
    
    
    // ****************** TABLEVIEW DELEGATE PROTOCOL FUNCTION ***************************

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingContent.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pending", for: indexPath) as! Pending_TableViewCell
        cell.selectionStyle = .none
        
        
        let currentDate = Date()
        let pendingTimestamp = (pendingContent[indexPath.row].contractStatusUpdated)! / 1000
        
        print(currentDate)
        print("\(pendingTimestamp / 1000 )")
        
        let iOSTIME = Date(timeIntervalSince1970: TimeInterval(pendingTimestamp))
        print(iOSTIME)
        
        
        var showDate = self.getTimeComponentString(olderDate: iOSTIME, newerDate: currentDate)
        
        print(showDate)
        
        cell.closedLabel.text = "Closed \(showDate ?? "few seconds" ) ago"
        cell.nameLabel.text = pendingContent[indexPath.row].contactName
        cell.pendingCount.text = String(pendingContent[indexPath.row].allPendingDocumentCounts!)
        cell.contractNumber.text = pendingContent[indexPath.row].contractNumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        self.pending_Table.isUserInteractionEnabled = false

        contractDetail(Index: indexPath.row)
    }
    
    
    
    func contractDetail(Index : Int){
        
        
        let apiLink = appGlobalVariable.apiBaseURL+"contracts/getspecificcontract"
        
        let paramDict : [String : String    ] = [
            "userId": appGlobalVariable.userID,
            "contractId":(pendingContent[Index].id)!
            
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

}
