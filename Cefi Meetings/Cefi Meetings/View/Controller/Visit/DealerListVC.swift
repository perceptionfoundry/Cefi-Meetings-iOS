//
//  DealerListVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit


protocol addPersonDelegate {
    func personlistReload()
}


class DealerListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,addPersonDelegate{
    
    func personlistReload() {
        getContents()
        dealerListTable.reloadData()
    }
    
   
    

    @IBOutlet weak var DealerTitle: UILabel!
    
    @IBOutlet weak var dealerListTable: UITableView!
    
    
    


    
    var dealerList = [Dealer]()
    var delegateDealer : DealerDelegate!
    var ContactDetail : Meeting?
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let viewModel = GetDealerPersonViewModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dealerListTable.delegate = self
        dealerListTable.dataSource = self
        
        
        
        dealerListTable.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getContents()
        dealerListTable.reloadData()
    }
//
   
    

    
    // *************** TABLE VIEW PROTOCOL FUNCTION **********************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Dealer_List", for: indexPath) as! DealerTableViewCell
        cell.dealerName.isUserInteractionEnabled = false
        tableView.separatorStyle = .none
        cell.selectionStyle = .none
        
        
        cell.dealerName.text = dealerList[indexPath.row].personName
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(dealerList[indexPath.row].personName!)
        
        delegateDealer.selectedDealer(DealerName: dealerList[indexPath.row].personName!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
      
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editButton = UITableViewRowAction(style: .default, title: "Edit") { (rowAction, indexPath) in
            print("Edit")
//            cell.dealerName.isUserInteractionEnabled = true
//            self.dealerList.remove(at: indexPath.row)
//            self.dealerListTable.reloadData()
//            cell.dealerName.placeholder = "Editted Value"
            

            
        }
        editButton.backgroundColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
        
        
        let cancelButton = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
            
            print("Delete")
            self.dealerList.remove(at: indexPath.row)
            self.dealerListTable.reloadData()
            
        }
        cancelButton.backgroundColor = UIColor.red
        
        return[editButton, cancelButton]
    }
    
    // **************** GET TABLE CONTENT *****************
    
    func getContents(){
        
        dealerList.removeAll()
        
        let apiLink = appGlobalVariable.apiBaseURL+"dealerperson/getdealerperson"
        
        let paramDict : [String: String] = [
        "userId": appGlobalVariable.userID,
        "dealerId": (ContactDetail?.contactId)!
        
        ]
        
    print(apiLink)
        print(paramDict)
        
        viewModel.fetchDealerPersont(API: apiLink, TextFields: paramDict) { (status, error, result) in
            
            
            
            print(result)
            
            self.dealerList = result
            self.dealerListTable.reloadData()
            
            
             
            
        }
    }
    
    
    
    @IBAction func newDetailerAction(_ sender: Any) {
        
        performSegue(withIdentifier: "newDealer", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dest = segue.destination  as! AddDealerVC
        
        dest.dealerDele = self
        dest.ContactDetail = self.ContactDetail!
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

