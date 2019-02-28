//
//  MainContractsVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainContractsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // ****************** OUTLET ***************************

    @IBOutlet weak var NaviBar: UINavigationBar!
    @IBOutlet weak var contract_Table: UITableView!
    @IBOutlet weak var allButton: Custom_Button!
    @IBOutlet weak var openButton: Custom_Button!
    @IBOutlet weak var closedButton: Custom_Button!
    @IBOutlet weak var deadButton: Custom_Button!
    
    
    // ****************** VARIABLE ***************************

    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let viewModel = MainContractListViewModel()
    var userContract = [Contract]()
    var allContract = [Contract]()
    
    
    // ****************** VIEWDIDLOAD ***************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contract_Table.delegate = self
        contract_Table.dataSource = self
        
        
        let apiLink = appGlobalVariable.apiBaseURL + "contracts/getusercontracts"

        let param = ["userId": appGlobalVariable.userID]


        print(param)
        print(apiLink)


        // CALL VIEWMODEL FUNCTION
        viewModel.fetchContractDetail(API: apiLink, TextFields: param) { (status, Message, tableData) in

            if status == true{

                self.userContract = tableData
                self.allContract = tableData

                print("DISPLAY TABLE QUANTITY \(self.userContract.count)")


                print(self.userContract[0].equipmentDetails)



            }

            self.contract_Table.reloadData()
        }
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // show tab-bar controller
        self.tabBarController?.tabBar.isHidden = false
        self.fetchValue()
        
    }
    
    func fetchValue(){
        
        
        userContract.removeAll()
        allContract.removeAll()
        
        let apiLink = appGlobalVariable.apiBaseURL + "contracts/getusercontracts"
        
        let param = ["userId": appGlobalVariable.userID]
        
        
        print(param)
        print(apiLink)
        
        
        // CALL VIEWMODEL FUNCTION
        viewModel.fetchContractDetail(API: apiLink, TextFields: param) { (status, Message, tableData) in
            
            if status == true{
                
                self.userContract = tableData
                self.allContract = tableData
                
                print("DISPLAY TABLE QUANTITY \(self.userContract.count)")
                
                
                print(self.userContract[0].equipmentDetails)
                
                
                
            }
            
            self.contract_Table.reloadData()
    }
        
        // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        
        contract_Table.reloadData()

    }
    
    
    
    
    // ****************** VIEWWILLAPPEAR ***************************


   
    
    
    
    
    
    
    
    
    //  ******** SELECTION BUTTON ACTION FUNCTION ************************
    
    @IBAction func ListDisplayOption(_ sender: UIButton) {
        
        if sender.tag == 0{
            allButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor.clear
            
            userContract = allContract
            contract_Table.reloadData()
        }
        else if sender.tag == 1{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor.clear
            
            let value = self.contractFilter(option: "open")
            
            print(value)
            
            self.userContract = value
            
//
            contract_Table.reloadData()
        }
            
        else if sender.tag == 2{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            deadButton.border_color = UIColor.clear
            
            let value = self.contractFilter(option: "closed")
            
            print(value)
            
            self.userContract = value
            
            //
            contract_Table.reloadData()
        }
        else if sender.tag == 3{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            
            let value = self.contractFilter(option: "dead")
            
            print(value)
            
            self.userContract = value
            
            //
            contract_Table.reloadData()
        }
    }
    
    
    // ************* filter ********
    
    func contractFilter(option : String) -> [Contract]{
        
        
        var result = [Contract]()
        
        
        
        
        if option == "open"{
            result = allContract.filter( {$0.contractStatus == "open" }).map({ return $0 })
            
        }
        else if option == "closed"{
            result = allContract.filter( {$0.contractStatus == "closed" }).map({ return $0 })
            
            
        }
        else if option == "dead"{
            result = allContract.filter( {$0.contractStatus == "dead" }).map({ return $0 })
            
            
        }
       
        
        
        
        
        return result
    }
    
    
    
    
    
    // ****************** TABLEVIEW DELEGATE PROTOCAL FUNCTION ***************************

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userContract.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contract", for: indexPath) as! Contract_TableViewCell
        
        cell.selectionStyle = .none
        
        cell.alertView.isHidden = true
        
        cell.firstValue.text = userContract[indexPath.row].contractNumber
        cell.nameValue?.text = userContract[indexPath.row].contactName
        
        if userContract[indexPath.row].allPendingDocumentCounts! > 0 {
        
            cell.alertView.isHidden = false
            cell.quantity.text = String(userContract[indexPath.row].allPendingDocumentCounts!)
            
        }
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let values = userContract[indexPath.row]
        
        performSegue(withIdentifier: "contract_detail_segue", sender: values)
        
    }
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "contract_detail_segue"{
        let dest = segue.destination  as! ContractDetailsVC
        
        
//        print(sender as! Contract)
        
        
        dest.userContract = sender as! Contract
        }
    }
    
    // ****************** ADD CONTRACT BUTTON ACTION ***************************

    
    @IBAction func addContractAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contract")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
