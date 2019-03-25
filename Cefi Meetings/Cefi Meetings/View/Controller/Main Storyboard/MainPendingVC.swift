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
        
    self.getPending()
    }
    
    
    
    
    
    
    
    // ****************** VIEWWILLAPPEAR ***************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    
    // ****************** VIEWMODEL FUNCTION ***************************

    func getPending(){
        
        
        pendingContent.removeAll()
        
       
        
        
        let apiLink  = appGlobalVariable.apiBaseURL+"contracts/getpendingdocs?userId=\(appGlobalVariable.userID)"
        
        let paramKey : [String : String] = ["userId": appGlobalVariable.userID,
                                         
        ]
        
//        print(paramKey)
        
        viewModel.fetchPendingDocument(API: apiLink, TextFields: paramKey) { (status, err, Result) in
            
            
            
//            print(Result.count)
            
            if status == true{
                self.pendingContent = Result
                
                self.pendingQuantity.text = "\(self.pendingContent.count) pending documents"
                
                
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
        cell.closedLabel.text = "Closed \((pendingContent[indexPath.row].contractStatusUpdated)!) days ago"
        cell.nameLabel.text = pendingContent[indexPath.row].contactName
        cell.pendingCount.text = String(pendingContent[indexPath.row].allPendingDocumentCounts!)
        cell.contractNumber.text = pendingContent[indexPath.row].contractNumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
  

}
