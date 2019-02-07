//
//  EquipmentTypeVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 07/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class EquipmentTypeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var equipmentTable: UITableView!
    
    
    
    var titles =  ["Agricultural", "Construction", "Golf & Turf", "Healthcare", "Manufacturing", "Printing", "Technology", "Transporation", "Energy, Environmental Control","Furniture, Fixture & Equipment", "Material Handling", "Office Machine", "Telecommunication"]
    
    var selectedTitle = [String]()
    var equipmentDelegate : equipmentTypeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        equipmentTable.delegate = self
        equipmentTable.dataSource = self
        
        
        equipmentTable.allowsMultipleSelection = true
        equipmentTable.reloadData()

    }
    
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
        print(self.selectedTitle)

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! EquipmentTableViewCell


        if let index = self.selectedTitle.firstIndex(of:titles[indexPath.row]){

            print(index)

            self.selectedTitle.remove(at: index)



            cell.SelectedLabel.isHidden = true
        }

    }
    
    @IBAction func backAction(_ sender: Any) {
        
        equipmentDelegate.equipmentType(list: selectedTitle)
        self.navigationController?.popViewController(animated: true)
    }
    

}
