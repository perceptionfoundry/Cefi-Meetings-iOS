//
//  UserFilterVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class UserFilterVC: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var NaviBar: UINavigationBar!
    @IBOutlet weak var filterTable: UITableView!
    
    @IBOutlet weak var allButton: Custom_Button!
    @IBOutlet weak var leadButton: Custom_Button!
    @IBOutlet weak var clientButton: Custom_Button!
    @IBOutlet weak var dealerButton: Custom_Button!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        
        
        filterTable.delegate = self
        filterTable.dataSource = self
        
        filterTable.reloadData()
    }
    
   
    
    @IBAction func ListDisplayOption(_ sender: UIButton) {
        
        if sender.tag == 0{
            allButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            leadButton.border_color = UIColor.clear
            clientButton.border_color = UIColor.clear
            dealerButton.border_color = UIColor.clear
        }
        else if sender.tag == 1{
            allButton.border_color = UIColor.clear
            leadButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            clientButton.border_color = UIColor.clear
            dealerButton.border_color = UIColor.clear
        }
        else if sender.tag == 2{
            allButton.border_color = UIColor.clear
            leadButton.border_color = UIColor.clear
            clientButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            dealerButton.border_color = UIColor.clear
        }
        else if sender.tag == 3{
            allButton.border_color = UIColor.clear
            leadButton.border_color = UIColor.clear
            clientButton.border_color = UIColor.clear
            dealerButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Filter", for: indexPath) as! Contact_Filter_TableViewCell
        
        cell.userName.text = "user \(indexPath.row)"
        cell.businessName.text = "company \(indexPath.row)"

        
        return cell
    }
    
    @IBAction func newContactAction(_ sender: Any) {
        
        
        
        
        // Segue to New Contact  Viewcontroller
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contact")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func showGlobalList(_ sender: Any) {
    }
    
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

 

}
