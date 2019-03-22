//
//  UserFilterVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class UserFilterVC: UIViewController, UITableViewDataSource,UITableViewDelegate {

    
    
    // ****************** OUTLET ***************************

    @IBOutlet weak var NaviBar: UINavigationBar!
    @IBOutlet weak var filterTable: UITableView!
    @IBOutlet weak var allButton: Custom_Button!
    @IBOutlet weak var leadButton: Custom_Button!
    @IBOutlet weak var clientButton: Custom_Button!
    @IBOutlet weak var dealerButton: Custom_Button!
    @IBOutlet weak var statusSegment: UISegmentedControl!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var resultQuantityLabel: UILabel!
    
    
    
    
    
    
    
    
    // ****************** VARIABLE ***************************

    let appGlobalVarible = UIApplication.shared.delegate as! AppDelegate
    let viewModel = userFilterViewModel()
    var searchResult = [Contact]()
    
    
    
    
    
    
    
    
    
    
    
    // ****************** VIEWDIDLOAD ***************************

    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        
        
        filterTable.delegate = self
        filterTable.dataSource = self
        
        filterTable.reloadData()
    }
    
    
    
    
    
    
    
    
    
   
    //  ******** SELECTION BUTTON ACTION FUNCTION ************************

    @IBAction func ListDisplayOption(_ sender: UIButton) {
        
        if sender.tag == 0{
            
            allButton.setTitleColor(UIColor.black, for: .normal)
            leadButton.setTitleColor(UIColor.lightGray, for: .normal)
            clientButton.setTitleColor(UIColor.lightGray, for: .normal)
            dealerButton.setTitleColor(UIColor.lightGray, for: .normal)
            
            allButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            leadButton.border_color = UIColor.clear
            clientButton.border_color = UIColor.clear
            dealerButton.border_color = UIColor.clear
        }
        else if sender.tag == 1{
            allButton.setTitleColor(UIColor.lightGray, for: .normal)
            leadButton.setTitleColor(UIColor.black, for: .normal)
            clientButton.setTitleColor(UIColor.lightGray, for: .normal)
            dealerButton.setTitleColor(UIColor.lightGray, for: .normal)
            
            allButton.border_color = UIColor.clear
            leadButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            clientButton.border_color = UIColor.clear
            dealerButton.border_color = UIColor.clear
        }
        else if sender.tag == 2{
            
            allButton.setTitleColor(UIColor.lightGray, for: .normal)
            leadButton.setTitleColor(UIColor.lightGray, for: .normal)
            clientButton.setTitleColor(UIColor.black, for: .normal)
            dealerButton.setTitleColor(UIColor.lightGray, for: .normal)
            
            allButton.border_color = UIColor.clear
            leadButton.border_color = UIColor.clear
            clientButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            dealerButton.border_color = UIColor.clear
        }
        else if sender.tag == 3{
            allButton.setTitleColor(UIColor.lightGray, for: .normal)
            leadButton.setTitleColor(UIColor.lightGray, for: .normal)
            clientButton.setTitleColor(UIColor.lightGray, for: .normal)
            dealerButton.setTitleColor(UIColor.black, for: .normal)
            
            allButton.border_color = UIColor.clear
            leadButton.border_color = UIColor.clear
            clientButton.border_color = UIColor.clear
            dealerButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
        }
    }
    
    
    
    
    
    
    
    
    // ****************** VIEWWILLAPPEAR ***************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    
    
    
    
    
    // ****************** TABLEVIEWCONTROLLER PROTOCOL FUNCTION ***************************

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Filter", for: indexPath) as! Contact_Filter_TableViewCell
        cell.alertView.isHidden = true
        
        cell.userName.text = searchResult[indexPath.row].contactName
        cell.businessName.text = searchResult[indexPath.row].businessName

        
//        print(searchResult[indexPath.row])
        
        if (searchResult[indexPath.row].pendingDocuments) != nil{
            
            cell.alertView.isHidden = false
//            print(searchResult[indexPath.row].pendingDocuments)
            cell.quantity.text = String(searchResult[indexPath.row].pendingDocuments!)
            
        }
        else{
            cell.alertView.isHidden = true
        }
     


        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    
    
    
    
    
    // ****************** SEARCH ACTION FUNCTION ***************************

    @IBAction func searchAction(_ sender: Any) {
//        if searchTF.text?.isEmpty == true {
//            self.alertMessage(Title: "Text Field Empty", Message: "Please type search keyword")
//
//        }
//        else
//       { // STATUS SEGMENT
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
        
        
        // CALL VIEWMODEL FUNCTION
        viewModel.userFiltering(API: apiLink, TextFields: dict) { (status, result, message) in
            
            
            
            if status == true{
            self.searchResult = result!
                
//                print(self.searchResult.first)
                
                self.resultQuantityLabel.text = "\(self.searchResult.count) Result Found:"
            
            self.filterTable.reloadData()
            }
            
                
                
            else{
                let alert = UIAlertController(title: "Search Result", message: message!, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
//        }
        
    }
    
    
    
    
    
    
    
    // ****************** NEW CONTACT BUTTON ACTION ***************************

    
    @IBAction func newContactAction(_ sender: Any) {
        
        
        
        
        // Segue to New Contact  Viewcontroller
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contact")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
   
    
    
    
    
    // ****************** CANCEL BUTTON ACTION ***************************

    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    // ************* ALERT VIEWCONTROLLER ******************
    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
   

 

}
