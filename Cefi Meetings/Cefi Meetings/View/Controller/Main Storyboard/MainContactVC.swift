//
//  MainContactVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 24/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import Alamofire


class MainContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    //  OUTLET VARIBALE
    @IBOutlet weak var Contact_Table: UITableView!
    @IBOutlet weak var NaviBar: UINavigationBar!
    @IBOutlet weak var allButton: Custom_Button!
    @IBOutlet weak var leadButton: Custom_Button!
    @IBOutlet weak var clientButton: Custom_Button!
    @IBOutlet weak var dealerButton: Custom_Button!
    
    
    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    let viewModel = MainContactListViewModel()
    
    var listDisplay = "All"
    
    
    var userDirectory = [Contact]()
    
    
    var contactDelegate : contactdelegate?
    var segueStatus  = false
    
    
    
    var wordSection = [String]()
    var wordsDic = [String:[Contact]]()
    
    
    
    func generateWordDic(){
        
        
        
        
        
        for word in userDirectory{

        
            
            let key = (word.contactName?.first)
            
            let upper = String(key!).uppercased()
            
            
            wordSection.append(upper)
            
            
            
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
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        
        
        let apiLink = appGlobalVariable.apiBaseURL + "contacts/getusercontacts"
        
        let param = ["userId": appGlobalVariable.userID]
        
        print(param)
        print(apiLink)
      
        

        
        Contact_Table.delegate = self
        Contact_Table.dataSource = self
        
        
        viewModel.fetchContactDetail(API: apiLink, TextFields: param) { (status, Message, tableData) in
            
            if status == true{
                
                self.userDirectory = tableData
                
                
                print("DISPLAY TABLE QUANTITY \(self.userDirectory.count)")
                
                
                print(self.userDirectory[0].contactName)
                
//                self.Contact_Table.reloadData()
                
                self.generateWordDic()
                
            }
            
            self.Contact_Table.reloadData()
        }

        
        
        
        self.generateWordDic()
        
 
    
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
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // setting number of section in table
    func numberOfSections(in tableView: UITableView) -> Int {
        return wordSection.count
    }
    
    
    
    
    
    // ****************** Tableview Delegate protocol functions ***************************


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
        
        view.backgroundColor = UIColor.gray
        
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
        
        let workKey = wordSection[indexPath.section]
        
        

        if let wordValue = wordsDic[workKey.uppercased()]{



            cell.selectionStyle = .none
            
        cell.personName.text = wordValue[indexPath.row].contactName
        cell.companyName.text = wordValue[indexPath.row].businessName


        }
        return cell
    }

    
    // ************** See Particular user detail ****************
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let workKey = wordSection[indexPath.section]

        if segueStatus == true{
            
            if let wordValue = wordsDic[workKey.uppercased()]{
                
                
                print(wordValue[indexPath.row])
                
              
                
                self.contactDelegate?.contactName(userName: wordValue[indexPath.row].contactName!, id : wordValue[indexPath.row].id!)
                self.segueStatus = false
                self.dismiss(animated: true, completion: nil)
                
            }
            
           
        }
        
        else{
        // Segue to User Contail detail  Viewcontroller
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contact_Detail")
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    // ***********  Create new contact Action  ************
    
    @IBAction func newContactAction(_ sender: Any) {
        
        

        
        // Segue to New Contact  Viewcontroller
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contact")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
}
