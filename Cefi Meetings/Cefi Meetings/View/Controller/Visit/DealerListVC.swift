//
//  DealerListVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit





class DealerListVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
   
    

    @IBOutlet weak var DealerTitle: UILabel!
    
    @IBOutlet weak var dealerListTable: UITableView!
    
    
    
//    struct Dealer {
//        var dealerName : String
//
//    }

    
    var dealerList = [Dealer]()
    var delegateDealer : DealerDelegate!
    var ContactDetail : Meeting?
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let viewModel = GetDealerPersonViewModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dealerListTable.delegate = self
        dealerListTable.dataSource = self
        
        self.getContents()
        
        
        dealerListTable.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getContents()
    }
    
    // *************** TABLE VIEW PROTOCOL FUNCTION **********************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Dealer_List", for: indexPath) as! DealerTableViewCell
        
        tableView.separatorStyle = .none
        cell.selectionStyle = .none
        
        
        cell.dealerName.text = dealerList[indexPath.row].personName
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegateDealer.selectedDealer(DealerName:dealerList[indexPath.row].personName!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }

    
    
    // **************** GET TABLE CONTENT *****************
    
    func getContents(){
        
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
        
//        dest.dealerDele = self
        dest.ContactDetail = self.ContactDetail!
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

