//
//  DealerVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl



class DealerVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var dealerTable: UITableView!
    @IBOutlet weak var dealerContact: UILabel!
    
    
    @IBOutlet weak var saleStatus: TTSegmentedControl!
    
    @IBOutlet weak var newLead: TTSegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        saleStatus.itemTitles = ["Increased","Same","Deceased"]
        newLead.itemTitles = ["Yes", "No"]
        dealerTable.delegate = self
        dealerTable.dataSource = self
        
        
        let contactTap = UITapGestureRecognizer(target: self, action: #selector(dealerList))
        dealerContact.addGestureRecognizer(contactTap)
        
        dealerTable.reloadData()
       
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
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
