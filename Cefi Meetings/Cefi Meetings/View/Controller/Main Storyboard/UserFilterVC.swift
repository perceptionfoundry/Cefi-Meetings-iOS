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
    @IBOutlet weak var statusSegment: UISegmentedControl!
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var resultQuantityLabel: UILabel!
    
    let appGlobalVarible = UIApplication.shared.delegate as! AppDelegate
    
    let viewModel = userFilterViewModel()
    
    var searchResult = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        
        
        filterTable.delegate = self
        filterTable.dataSource = self
        
        filterTable.reloadData()
    }
    
   
    //  ******** Selection Button Action function ************************

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
        return searchResult.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Filter", for: indexPath) as! Contact_Filter_TableViewCell
        
        cell.userName.text = searchResult[indexPath.row].contactName
        cell.businessName.text = searchResult[indexPath.row].businessName

        
        return cell
    }
    
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        
        var status = ""
        if statusSegment.selectedSegmentIndex == 0{
            status = "closed"
        }
        else if statusSegment.selectedSegmentIndex == 1{
            status = "open"

        }
        else if statusSegment.selectedSegmentIndex == 2{
            status = "dead"

        }

        
        
        let apiLink = appGlobalVarible.apiBaseURL+"contacts/getfiltercontacts"
        
        let dict = [
            "userId": appGlobalVarible.userID,
            "searchField": searchTF.text!,
            "status": status
            
        ]
        
        viewModel.userFiltering(API: apiLink, TextFields: dict) { (status, result) in
            
            self.searchResult = result!
            
//            print(result)
            
            self.filterTable.reloadData()
        }
        
    }
    
    
    
    
    
    @IBAction func newContactAction(_ sender: Any) {
        
        
        
        
        // Segue to New Contact  Viewcontroller
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contact")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
   
    
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

 

}
