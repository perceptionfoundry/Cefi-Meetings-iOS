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
    
    
    let sample =  [["name": "Absher", "company":"logi"],
                   ["name": "Faisal", "company":"fuzz"],
                   ["name": "Shahrukh", "company":"Perception"],
                   ["name": "Danish", "company":"Axiom"],
                   ["name": "Ahsan", "company":"PIAIC"],
                   ["name": "Zubair", "company":"Panacloud"],
                   ]
    
    let section_Index = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    
    var wordSection = [String]()
    var wordsDic = [String:[[String:String]]]()
    
    func generateWordDic(){
        
        for word in sample{
            let key = "\(word["name"]?.startIndex)"
            let upper = key.uppercased()
            
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        Contact_Table.delegate = self
        Contact_Table.dataSource = self
        
        self.generateWordDic()
    
        Contact_Table.reloadData()
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return section_Index.count
    }
    
   
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//
//
//        return section_Index[section]
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        let workKey = wordSection[section]
//
//        if let wordValues = wordsDic[workKey]{
//            return wordValues.count
//        }
//
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.backgroundColor = UIColor.init(hexColor: "59913A")
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.frame = CGRect(x: 15, y: -5, width: 100, height: 35)
        label.text = section_Index[section]
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath) as! Contact_TableViewCell
        
//
//        let workKey = wordSection[indexPath.section]
//
//        if let wordValue = wordsDic[workKey.uppercased()]{
//
//        cell.personName.text = wordValue[indexPath.section]["Name"]
//
//        }
        return cell
    }

    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return section_Index
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
