//
//  MainContactVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 24/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var Contact_Table: UITableView!
    @IBOutlet weak var NaviBar: UINavigationBar!
    
    
    let sample =  [["name": "Absher", "company":"logi"],
                   ["name": "Faisal", "company":"fuzz"],
                   ["name": "Shahrukh", "company":"Perception"],
                   ["name": "Danish", "company":"Axiom"],
                   ["name": "Ahsan", "company":"PIAIC"],
                   ["name": "Zubair", "company":"Panacloud"],
                   ]
    
    
    
//    let section_Index = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    
    var wordSection = [String]()
    var wordsDic = [String:[[String:String]]]()
    
    
    
    func generateWordDic(){
        
        for word in sample{
            
            let key = (word["name"]?.first)
            
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
        
        Contact_Table.delegate = self
        Contact_Table.dataSource = self
        
        self.generateWordDic()
    
        Contact_Table.reloadData()
    }
  
    
    // setting number of section in table
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
        
//
        let workKey = wordSection[indexPath.section]
        
        print(workKey)
        

        if let wordValue = wordsDic[workKey.uppercased()]{


            print(wordValue[indexPath.row])
        
            cell.selectionStyle = .none
            
        cell.personName.text = wordValue[indexPath.row]["name"]
        cell.companyName.text = wordValue[indexPath.row]["company"]


        }
        return cell
    }

    
    // ************** See Particular user detail ****************
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Segue to User Contail detail  Viewcontroller
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contact_Detail")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    // ***********  Create new contact ************
    
    @IBAction func newContactAction(_ sender: Any) {
        
        

        
        // Segue to New Contact  Viewcontroller
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contact")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
}
