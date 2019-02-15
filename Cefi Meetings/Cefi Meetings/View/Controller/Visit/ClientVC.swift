//
//  ClientVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 05/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl



class ClientVC: UIViewController {
    
    
    @IBOutlet weak var dealerContact: UILabel!
    
    
    @IBOutlet weak var businessSegment: TTSegmentedControl!
    
    @IBOutlet weak var EquipmentSegment: TTSegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        businessSegment.itemTitles = ["Deceased","Same","Increased"]
        EquipmentSegment.itemTitles = ["Yes", "Maybe", "No"]
        
        
        businessSegment.allowChangeThumbWidth = false
        EquipmentSegment.allowChangeThumbWidth = false
        
        
        
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
