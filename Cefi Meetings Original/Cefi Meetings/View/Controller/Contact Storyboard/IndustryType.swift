//
//  IndustryType.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 18/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class IndustryType: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var industryTable: UITableView!
    
    
    
    // ****************** VARIABLE  **********************

    
    var titles =  ["Agricultural", "Mining", "Construction", "Manufacturing", "Transporation & Public Utilities","Wholesale Trade", "Retail Trade", "Finance, Insurance, Real Estate", "Services", "Public" ]
    var selectedTitle = [String]()
    var equipmentDelegate : equipmentTypeDelegate!
    
    
    
    
    // ******************  VIEW DID LOAD **********************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        industryTable.delegate = self
        industryTable.dataSource = self
        
        
        industryTable.allowsMultipleSelection = true
        industryTable.reloadData()
        
    }
    
    
    
    // ****************** TABLEVIEW PROTOCOL  **********************

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Equipment_Type", for: indexPath) as! EquipmentTableViewCell
        
        tableView.separatorStyle = .none
        cell.selectionStyle = .none
        
        cell.SelectedLabel.isHidden = true
        cell.EquipmentTitle?.text = titles[indexPath.row]
        
        
        if self.selectedTitle.contains(titles[indexPath.row]){
            
            cell.SelectedLabel.isHidden = false
            
            
        }
        else{
            cell.SelectedLabel.isHidden = true
            
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.cellForRow(at: indexPath) as! EquipmentTableViewCell
        
        cell.SelectedLabel.isHidden = false
        
        if selectedTitle.contains(titles[indexPath.row]) == false{
            self.selectedTitle.append(titles[indexPath.row])
        }
//        print(self.selectedTitle)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! EquipmentTableViewCell
        
        
        if let index = self.selectedTitle.firstIndex(of:titles[indexPath.row]){
            
//            print(index)
            
            self.selectedTitle.remove(at: index)
            
            
            
            cell.SelectedLabel.isHidden = true
        }
        
    }
    
    
    
    
    
    // ****************** BACK BUTTON ACTION  **********************

    @IBAction func backAction(_ sender: Any) {
        
        equipmentDelegate.equipmentType(list: selectedTitle)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
