//
//  ContractVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

protocol contactContractDelegate{
    func getContract(Value: String)
}





class ContractVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
  
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var contractTable: UITableView!
    @IBOutlet weak var unemptyTableImage: UIImageView!
    
    
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var selectedUserName = ""
    var selectedUserID = ""
    var viewModel = ContactContractDetailViewModel()
    var tableContent = [Contract]()
    var justTest = true
    
    var contractDelegate : contactContractDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contractTable.delegate = self
        contractTable.dataSource = self
        
        
        contractTable.isHidden = true
        
        
        
        fieldUpdate()
 
        
        
        
        
        
        
    }
    
    
    
    func fieldUpdate(){
        userName.text = selectedUserName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableContent.removeAll()
        fetchContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func fetchContent(){
        let apiLink = appGlobalVariable.apiBaseURL+"contracts/getcontactcontracts"
        
        let dict : [String : String] = [
            "userId":appGlobalVariable.userID,
            "contactId": selectedUserID
            
        ]
        viewModel.fetchContractDetail(API: apiLink, TextFields: dict) { (status, message, result, count) in
            
            
//            print(count)
            
            self.tableContent = result
            
            if result.count != 0{
                self.contractTable.isHidden = false
                self.unemptyTableImage.isHidden = true
                
            }
            
            self.contractTable.reloadData()
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableContent.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contract", for: indexPath) as! UserDetailContract_TableView
        
        cell.selectionStyle = .none
        
        cell.alertView.isHidden = true
        
        cell.statuslabel.text = tableContent[indexPath.row].contractStatus
        cell.numberLabel.text = tableContent[indexPath.row].contractNumber
        
        if tableContent[indexPath.row].allPendingDocumentCounts! > 0{
            cell.alertView.isHidden = false
            cell.pendingQuantity.text = String(tableContent[indexPath.row].allPendingDocumentCounts!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        contractDelegate?.getContract(Value: tableContent[indexPath.row].id!)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func editAction(_ sender: Any) {
        performSegue(withIdentifier: "Edit_Segue", sender: nil)
    }
    
    
    
    
    
    @IBAction func addContractAction(_ sender: Any) {
        
        
        performSegue(withIdentifier: "Contract_Segue", sender: nil)
        
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "Contract_Segue"{
            let dest = segue.destination as! NewContractVC
            
        dest.contactName = selectedUserName
            dest.selectedContactID = selectedUserID
        }
    }
    
}
