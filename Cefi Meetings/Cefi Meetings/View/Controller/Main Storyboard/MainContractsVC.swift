//
//  MainContractsVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainContractsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var NaviBar: UINavigationBar!

    @IBOutlet weak var contract_Table: UITableView!
    @IBOutlet weak var allButton: Custom_Button!
    @IBOutlet weak var openButton: Custom_Button!
    @IBOutlet weak var closedButton: Custom_Button!
    @IBOutlet weak var deadButton: Custom_Button!
    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    let viewModel = MainContractListViewModel()
    
    
    
    var userContract = [Contract]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contract_Table.delegate = self
        contract_Table.dataSource = self
        
        
        let apiLink = appGlobalVariable.apiBaseURL + "contracts/getusercontracts"
        
        let param = ["userId": appGlobalVariable.userID]
        
        
        print(param)
        print(apiLink)
        
        
        viewModel.fetchContractDetail(API: apiLink, TextFields: param) { (status, Message, tableData) in
            
            if status == true{
                
                self.userContract = tableData
                
                
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
    
    
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        // show tab-bar controller
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    
    
    
    
    //  ******** Selection Button Action function ************************
    
    @IBAction func ListDisplayOption(_ sender: UIButton) {
        
        if sender.tag == 0{
            allButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor.clear
        }
        else if sender.tag == 1{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor.clear
        }
        else if sender.tag == 2{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            deadButton.border_color = UIColor.clear
        }
        else if sender.tag == 3{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
        }
    }
    
    
    
    
    
    
    
    
    // ****************** Tableview Delegate protocol functions ***************************

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userContract.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contract", for: indexPath) as! Contract_TableViewCell
        
        cell.selectionStyle = .none
        
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contract_Detail")
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
  
    @IBAction func addContractAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contract")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
