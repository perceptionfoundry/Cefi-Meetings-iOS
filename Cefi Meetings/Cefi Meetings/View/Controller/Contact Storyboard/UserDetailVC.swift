//
//  UserDetailVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var typeCategory: UILabel!
    @IBOutlet weak var industryCatergory: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    
    @IBOutlet weak var contractTable: UITableView!
    
    
    @IBOutlet weak var unemptyTableImage: UIImageView!
    
    
    var userDetail : Contact?
    
    var justTest = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contractTable.delegate = self
        contractTable.dataSource = self

        print(userDetail!)

        
        
        userName.text = userDetail!.contactName
        businessName.text = userDetail!.businessName
        typeCategory.text = userDetail?.contactType
        industryCatergory.text = userDetail!.industryType
        
        var phone = userDetail!.phoneNumber!
        phoneNumber.text = String(phone)
        emailAddress.text = userDetail!.email
        
        
        
        
        contractTable.reloadData()
        contractTable.isHidden = true
        
        

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 2
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contract", for: indexPath) as! UserDetailContract_TableView
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    
    
    
    
    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func editAction(_ sender: Any) {
    }
    
    
    
    
    
    @IBAction func addContractAction(_ sender: Any) {
        
        
        performSegue(withIdentifier: "Contract_Segue", sender: nil)
        
        if justTest == true{
            justTest = false
            contractTable.isHidden = false
            unemptyTableImage.isHidden = true
        }
        else{
            justTest = true
            contractTable.isHidden = true
            unemptyTableImage.isHidden = false

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! NewContractVC
        
        dest.contactName = userDetail!.contactName!
    }
    
}
