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
    
  
    
    @IBOutlet weak var timeLabel: UILabel!
    var selectedVisit = [Int]()
    
    
    
    var dummyData = [["Type":"Client", "User":"David","Business":"ABC corp","Rating":"4","Timing":"11:15 am"],
                     ["Type":"Follow-Up", "User":"Peter","Business":"BB corp","Rating":"3","Timing":"06:15 pm"],
                     ["Type":"Dealer", "User":"Tom","Business":"XYZ corp","Rating":"2","Timing":"08:15 pm"],
                     ["Type":"Prospecting", "User":"Jack","Business":"PQR corp","Rating":"5","Timing":"04:15 pm"],

    ]
    
    
    var visitCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitTable.delegate = self
        visitTable.dataSource = self
        
      
        
        visitTable.allowsMultipleSelection = true

        
        
        visitTable.reloadData()

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
 
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

//        let cell = Bundle.main.loadNibNamed("VisitTableViewCell", owner: self, options: nil)?.first as! VisitTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Visit", for: indexPath) as! VisitTableViewCell

        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
//
        
        
        var type = dummyData[indexPath.row]["Type"]
        
        if type == "Dealer"{
            
//            cell.topView.backgroundColor = UIColor(red: 14.0, green: 65.0, blue: 3.0, alpha: 1)
            cell.typeLabel.textColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
            cell.userNameLabel.textColor = UIColor.white
            cell.businessNameLabel.textColor = UIColor.white
            cell.timeLabel.textColor = UIColor.white
            cell.callNowButton.setImage(UIImage(named: "call_now_light"), for: .normal)
            
            cell.typeLabel.text = dummyData[indexPath.row]["Type"]
            cell.businessNameLabel.text = dummyData[indexPath.row]["Business"]
            cell.userNameLabel.text = dummyData[indexPath.row]["User"]
           
            let rating = Int(dummyData[indexPath.row]["Rating"]!)
            let value = Double(exactly: rating!)
            cell.ratingStar.value = CGFloat(value!)
            
            cell.timeLabel.text = dummyData[indexPath.row]["Timing"]
            
            
            cell.bottomStartButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
            cell.bottomDetailButton.addTarget(self, action: #selector(detailView), for: .touchUpInside)
            
        }
  
        else if type == "Client" || type == "Follow-Up" || type == "Prospecting" {
            
        cell.topView.backgroundColor = UIColor.white

        cell.typeLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)

        cell.userNameLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
        cell.businessNameLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
        cell.timeLabel.textColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
            
            cell.typeLabel.text = dummyData[indexPath.row]["Type"]
            cell.businessNameLabel.text = dummyData[indexPath.row]["Business"]
            cell.userNameLabel.text = dummyData[indexPath.row]["User"]
            
            let rating = Int(dummyData[indexPath.row]["Rating"]!)
            let value = Double(exactly: rating!)
            cell.ratingStar.value = CGFloat(value!)
            
            cell.timeLabel.text = dummyData[indexPath.row]["Timing"]
            
            
            cell.bottomStartButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
            cell.bottomDetailButton.addTarget(self, action: #selector(detailView), for: .touchUpInside)

            
        }
        
        
        
       
        

        
        
        
        if self.selectedVisit.contains(indexPath.row){

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

        self.selectedVisit.append(indexPath.row)

        cell.bottomStartButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
       
        visitCategory = dummyData[indexPath.row]["Type"]!
            
        UIView.animate(withDuration: 1.0) {
            cell.topView.frame.origin.y = 20
//
            cell.bottomView.frame.origin.y = 60
            
//            self.visitTable.beginUpdates()
//            self.visitTable.endUpdates()
        }
     
        print(selectedVisit)
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        let cell =  visitTable.cellForRow(at: indexPath) as! VisitTableViewCell


        if let i = self.selectedVisit.index(of: indexPath.row) {

            UIView.animate(withDuration: 1.0) {
                cell.topView.frame.origin.y = 50
                cell.bottomView.frame.origin.y = 50
                
//                self.visitTable.beginUpdates()
//                self.visitTable.endUpdates()
            }

            self.selectedVisit.remove(at: i)

            print(selectedVisit)
        


        }
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {


//        if self.selectedVisit.contains(indexPath.row){
//
//     return 210
//
////
//        }
       
          return 160

    }
  
    

    
    @objc func startMeeting(){
     
        
        if visitCategory == "Prospecting"{
            
            let storyboard = UIStoryboard(name: "Visit", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "Prospecting")
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        else if visitCategory == "Dealer"{
            let storyboard = UIStoryboard(name: "Visit", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "Dealer")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if visitCategory == "Client" {
            let storyboard = UIStoryboard(name: "Visit", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "Client")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if visitCategory == "Follow-Up"{
            
            
            
            let storyboard = UIStoryboard(name: "Visit", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "Follow_Up")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
       
        
    }
    
    
    @objc func detailView(){
        let storyboardRef =  UIStoryboard(name: "Visit", bundle: nil)
        
        let vc = storyboardRef.instantiateViewController(withIdentifier: "Visit_Detail")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        let storyboardRef =  UIStoryboard(name: "Visit", bundle: nil)
        
        let vc = storyboardRef.instantiateViewController(withIdentifier: "New_Visit")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
