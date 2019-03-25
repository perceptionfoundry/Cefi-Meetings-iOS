//
//  MainContactVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 24/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Alamofire


class MainContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    
    
    
    
    
    // ******************* OUTLET ***************************
    
    @IBOutlet weak var Contact_Table: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var NaviBar: UINavigationBar!
    @IBOutlet weak var allButton: Custom_Button!
    @IBOutlet weak var leadButton: Custom_Button!
    @IBOutlet weak var clientButton: Custom_Button!
    @IBOutlet weak var dealerButton: Custom_Button!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    
    
    
    
    
    
    // ******************* VARIABLE ***************************

    var selectedUser : Contact?
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let viewModel = MainContactListViewModel()
    var listDisplay = "All"
    var userDirectory = [Contact]()
    var allUser = [Contact]()
    var contactDelegate : contactdelegate?
    var segueStatus  = false
    var visitSegue = false
    var wordSection = [String]()
    var wordsDic = [String:[Contact]]()
    
    
    var lastData = [Contact]()
    
    
    
    

    
    // ******************* VIEWDIDLOAD ***************************

    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isHidden = true

        if segueStatus == true{
            backButton.isHidden = false
        }
        
       // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        

        Contact_Table.delegate = self
        Contact_Table.dataSource = self
        
        searchTF.delegate = self
        
        self.generateWordDic()
        
 
    
    }
  
    // ******************  VIEW DID APPEAR ***********************

    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        

        self.fetchingContent()
        
    
    }
    
    
    
    
    // ******************  VIEW WILL APPEAR ***********************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    
    
    
    
    // ******************* FUNCTION THAT WILL GENERATION "KEY" "ALPHABET" AGAINST "VALUE" FROM USER-DICTIONARY ***************************
    
    func generateWordDic(){
        
        
        
        
        
        for word in userDirectory{
            
            
            // EXTRACT KEY FROM USER-DIRECTORY
            
            let key = (word.contactName?.first)
            
            let upper = String(key!).uppercased()
            
            wordSection.append(upper)
            
            
            // COLLECTING  DATA INTO MAIN VARIABLE
            if var wordValues = wordsDic[upper]{
                
                wordValues.append(word)
                wordsDic[upper] = wordValues
                
                
            }
                
            else{
                wordsDic[upper] = [word]
            }
        }
        
        
        
        wordSection = [String](wordsDic.keys)
        wordSection = wordSection.sorted()
        
    }
    
    
    
    
    
    
    
    
    // *********** TEXTFIELD DELEGATE FUNCTION ******
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if searchTF.text?.isEmpty == false {
        self.userDirectory = lastData
        }
        searchTF.text = ""
        
        self.wordsDic.removeAll()
        generateWordDic()
        Contact_Table.reloadData()
        
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    //  ******** SELECTION BUTTON OPTION FUNCTION ************************

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
            
            self.userDirectory = allUser
            
            self.wordsDic.removeAll()
            generateWordDic()
            Contact_Table.reloadData()

            
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
            
            let value = self.directoryFilter(option: "Lead")
            
            
            self.userDirectory = value
            
            self.wordsDic.removeAll()
            generateWordDic()
            Contact_Table.reloadData()
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
            
            let value = self.directoryFilter(option: "Client")
            
            
            self.userDirectory = value
            
            self.wordsDic.removeAll()
            generateWordDic()
            Contact_Table.reloadData()

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
            
            let value = self.directoryFilter(option: "Dealer")
            
            
            self.userDirectory = value
            self.wordsDic.removeAll()

            generateWordDic()
            Contact_Table.reloadData()

        }
    }
    
    
    
    
    
    
    
    
    // ************* FILTERING AS PER CONTACT TYPE ********
    
    func directoryFilter(option : String) -> [Contact]{
        
        
        var result = [Contact]()
        
        
        
            
            if option == "Lead"{
                result = allUser.filter( {$0.contactType == "Lead" }).map({ return $0 })

            }
            else if option == "Client"{
                result = allUser.filter( {$0.contactType == "Client" }).map({ return $0 })

                
            }
            else if option == "Dealer"{
                result = allUser.filter( {$0.contactType == "Dealer" }).map({ return $0 })

                
            }
            else if option == "Prospect"{
                result = allUser.filter( {$0.contactType == "Prospect" }).map({ return $0 })

                
            }
        

     
        
        return result
    }
  
    
    
    
    
    
    
    
    //  ******** FETCHING CONTENT FUNCTION ************************

    func fetchingContent(){
        
        
        userDirectory.removeAll()
        wordsDic.removeAll()
        
        
        
        let apiLink = appGlobalVariable.apiBaseURL + "contacts/getusercontacts"
        
        let param = ["userId": appGlobalVariable.userID]
        
      
        
        
        
        // CALLING VIEWMODEL FUNCTION
        viewModel.fetchContactDetail(API: apiLink, TextFields: param) { (status, Message, tableData) in
            
            if status == true{
                
                self.userDirectory = tableData
                self.allUser = tableData
                
//                print("DISPLAY TABLE QUANTITY \(self.userDirectory.count)")
                
                
//
                
                self.generateWordDic()
                
            }
            
            self.Contact_Table.reloadData()
        }
        
    }
    
    
    
    
    
    
    
    
    // ****************** Tableview Delegate protocol functions ***************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return wordSection.count
    }


    // Configure number item in row of section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
//        List of all section KEY
        
        let workKey = wordSection[section]


        if let wordValues = wordsDic[workKey]{
            return wordValues.count
        }

        return 0

    }
    
    
    // Configure Section look and attribute
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor.lightGray
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.frame = CGRect(x: 15, y: -5, width: 100, height: 35)
        label.text = wordSection[section]
        
        view.addSubview(label)
        
        return view
    }
    
    
    // Associating items in cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath) as! Contact_TableViewCell
        
        
        cell.pendingButton.isHidden = true
        
        let workKey = wordSection[indexPath.section]
        
        

        if let wordValue = wordsDic[workKey.uppercased()]{



            cell.selectionStyle = .none
            
        cell.personName.text = wordValue[indexPath.row].contactName
        cell.companyName.text = wordValue[indexPath.row].businessName
            
            if wordValue[indexPath.row].pendingDocuments! == 0{
                cell.alertvVew.isHidden = true
            }
        cell.quantity.text = String(wordValue[indexPath.row].pendingDocuments!)
        
            

        }
        return cell
    }

    
    
    
    
    
    //  See Particular user detail
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print(segueStatus)
        
        let workKey = wordSection[indexPath.section]

        if segueStatus == true{
            
            if let wordValue = wordsDic[workKey.uppercased()]{
                
                
                
              self.selectedUser = wordValue[indexPath.row]
                
                if wordValue[indexPath.row].contactType != "Dealer" {
                
                self.contactDelegate?.contactName(userName: wordValue[indexPath.row].contactName!, id : wordValue[indexPath.row].id!, ContractNumber : true, businessName: wordValue[indexPath.row].businessName!)
                self.segueStatus = false
                    backButton.isHidden = true

                self.dismiss(animated: true, completion: nil)
            }
                
                else{
                    let alert = UIAlertController(title: "Alert!", message: "This user cannot me selected as He / She is a Dealer", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
           
        }
            
        else if visitSegue == true{
            
            if let wordValue = wordsDic[workKey.uppercased()]{
                
                
                
                self.selectedUser = wordValue[indexPath.row]
                
               
                var contractNUM = false
                
                if wordValue[indexPath.row].contactType != "Dealer"{
                    contractNUM = true
                }
                
                    
                    self.contactDelegate?.contactName(userName: wordValue[indexPath.row].contactName!, id :wordValue[indexPath.row].id!, ContractNumber : contractNUM, businessName: wordValue[indexPath.row].businessName!)
                    self.segueStatus = false
                
                    self.dismiss(animated: true, completion: nil)
                
                    
                
                
            }
            
            
        }
        
        else{
            
            
        // Segue to User Contail detail  Viewcontroller
        
           
                
                if let wordValue = wordsDic[workKey.uppercased()]{
                    
                    
                    
                    self.selectedUser = wordValue[indexPath.row]
                    
//                    print(selectedUser?.contactName)
                    
                    performSegue(withIdentifier: "Contact_Segue", sender: nil)
//                   
                    
            }
                    
            
            
            
            

        }
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
   
    @IBAction func BackButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
    
    
    
    
    // ***********  SEARCH OPERATION  ************

    
    @IBAction func searchButtonAction(_ sender: Any) {
       
    searchTF.endEditing(true)
        
        if searchTF.text?.isEmpty == true{
            
            
            self.alertMessage(Title: "Text Field Empty", Message: "Please type search keyword")
        }
        
        else{
            
            self.lastData = self.userDirectory
            let currentTableData = self.userDirectory
//
            
            let result = currentTableData.filter( {($0.contactName?.contains(searchTF.text!))!}).map({ return $0 })

//
            
            self.userDirectory = result
            
            self.wordsDic.removeAll()
            generateWordDic()
            Contact_Table.reloadData()
        }
    }
    
    
    
    
    
    
    // ***********  ALERT VIEWCONTROLLER  ************

    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    // ***********  CREATE NEW CONTACT FUNCTION  ************
    
    @IBAction func newContactAction(_ sender: Any) {
        
        

        
        // Segue to New Contact  Viewcontroller
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contact")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Contact_Segue"{

            let dest = segue.destination as! UserDetailVC


        dest.userDetail = self.selectedUser
        }
    }
    
}
