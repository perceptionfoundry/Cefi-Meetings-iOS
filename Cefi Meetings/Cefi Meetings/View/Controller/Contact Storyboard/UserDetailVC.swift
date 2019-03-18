//
//  UserDetailVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, contactChange {
    
    
    
    
    
    // ****************** PROTOCOL FUNCTION *****************

    func editContact(value: Contact) {
        
//        print(value)
        
        self.userDetail = value
        
        fieldUpdate()
    }
    
    
    
    
    
    
    // ****************** OUTLET *****************

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var typeCategory: UILabel!
    @IBOutlet weak var industryCatergory: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var contractTable: UITableView!
    @IBOutlet weak var unemptyTableImage: UIImageView!
    
    
    
    
    
    
    // ****************** VARIABLE *****************

    
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    var viewModel = ContactContractDetailViewModel()
    var userDetail : Contact?
    var tableContent = [Contract]()
    var justTest = true
    
    
    
    
    
    
    // ****************** VIEW DID LOAD *****************

    
    override func viewDidLoad() {
        super.viewDidLoad()

        contractTable.delegate = self
        contractTable.dataSource = self

        
        contractTable.isHidden = true

        
        
        fieldUpdate()

        
        

        
        

    }
    
    
    
 // *************** VIEW DID APPEAR  *********************
    
    override func viewDidAppear(_ animated: Bool) {
        tableContent.removeAll()
        fetchContent()
    }
    
    
    

    // ********************** VIEW WILL APPEAR  ************************
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    
    
    
    // ******************  TEXT FIELD UPDATE FUNCTION **********************
    func fieldUpdate(){
        userName.text = userDetail!.contactName
        businessName.text = userDetail!.businessName
        typeCategory.text = userDetail?.contactType
        industryCatergory.text = userDetail!.industryType
        
        let phone = userDetail!.phoneNumber!
        phoneNumber.text = String(phone)
        emailAddress.text = userDetail!.email
    }
    
    
    
    
    
    
    
    // ****************** VIEWMODEL FUNCTION  **********************

    func fetchContent(){
        let apiLink = appGlobalVariable.apiBaseURL+"contracts/getcontactcontracts"
        
        let dict : [String : String] = [
            "userId":appGlobalVariable.userID,
            "contactId": userDetail!.id!
            
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
    
    
    
    
    // ****************** TABLEVIEW PROTOCOL  **********************

    
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
    
    
    
    
    
    // ****************** BACK BUTTON ACTION  **********************

    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    // ****************** EDIT BUTTON ACTION  **********************

    
    @IBAction func editAction(_ sender: Any) {
        performSegue(withIdentifier: "Edit_Segue", sender: nil)
    }
    
    
    
    
    
    // ****************** ADD BUTTON ACTION  **********************

    
    
    @IBAction func addContractAction(_ sender: Any) {
        
        
        performSegue(withIdentifier: "Contract_Segue", sender: nil)
        

    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Edit_Segue"{
            let dest = segue.destination  as! EditContactVC
            dest.contactDetail = userDetail!
            dest.editDelegate = self
        }
        else if segue.identifier == "Contract_Segue"{
        let dest = segue.destination as! NewContractVC
        
        dest.contactName = userDetail!.contactName!
        dest.selectedContactID = userDetail!.id!
        }
    }
    
}
