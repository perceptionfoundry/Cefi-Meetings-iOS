//
//  VisitVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class VisitVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var visitTable: UITableView!
    
    
var selectedSkill = [Int]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitTable.delegate = self
        visitTable.dataSource = self
        
      
        
        visitTable.allowsMultipleSelection = true

        
        
        visitTable.reloadData()

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
 
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

//        let cell = Bundle.main.loadNibNamed("VisitTableViewCell", owner: self, options: nil)?.first as! VisitTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Visit", for: indexPath) as! VisitTableViewCell

        cell.selectionStyle = .none
        tableView.separatorStyle = .none
//
        
        if self.selectedSkill.contains(indexPath.row){

                cell.topView.frame.origin.y = 20

                cell.bottomView.frame.origin.y = 60
           

        }
        else{

                cell.topView.frame.origin.y = 50

                cell.bottomView.frame.origin.y = 50
           
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
let cell =  visitTable.cellForRow(at: indexPath) as! VisitTableViewCell
//         let cell = tableView.dequeueReusableCell(withIdentifier: "Visit", for: indexPath) as! VisitTableViewCell

        self.selectedSkill.append(indexPath.row)

        UIView.animate(withDuration: 1.0) {
            cell.topView.frame.origin.y = 20
            
            cell.bottomView.frame.origin.y = 60
        }
     
        print(selectedSkill)
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        let cell =  visitTable.cellForRow(at: indexPath) as! VisitTableViewCell
//         let cell = tableView.dequeueReusableCell(withIdentifier: "Visit", for: indexPath) as! VisitTableViewCell


        if let i = self.selectedSkill.index(of: indexPath.row) {

            UIView.animate(withDuration: 1.0) {
                cell.topView.frame.origin.y = 50

                cell.bottomView.frame.origin.y = 50
            }

            self.selectedSkill.remove(at: i)

            print(selectedSkill)
        


        }
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       
        
          return 210
            
            
     
       
       
        
    }
    


}
