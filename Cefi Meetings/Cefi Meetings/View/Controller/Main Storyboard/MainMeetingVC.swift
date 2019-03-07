//
//  MainMeetingVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainMeetingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    
    //  *************** OUTLET ************************

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var visitTable: UITableView!
    @IBOutlet weak var NaviBarDate: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    //  *************** VARIABLE ************************
    var appGlobalVariable = UIApplication.shared.delegate  as! AppDelegate
    var selectedVisit = [Int]()
    var selected = -1
    var visitCategory = ""
    var viewModel = MainMeetingViewModel()
    
    
    
//    var MeetingContent = [["Type":"Client", "User":"David","Business":"ABC corp","Rating":"4","Timing":"11:15 am"],
//                     ["Type":"Follow Up", "User":"Peter","Business":"BB corp","Rating":"3","Timing":"06:15 pm"],
//                     ["Type":"Dealer", "User":"Tom","Business":"XYZ corp","Rating":"2","Timing":"08:15 pm"],
//                     ["Type":"Prospecting", "User":"Jack","Business":"PQR corp","Rating":"5","Timing":"04:15 pm"],
//                     ["Type":"Client", "User":"David","Business":"ABC corp","Rating":"4","Timing":"11:15 am"],
//                     ["Type":"Follow Up", "User":"Peter","Business":"BB corp","Rating":"3","Timing":"06:15 pm"],
//                     ["Type":"Dealer", "User":"Tom","Business":"XYZ corp","Rating":"2","Timing":"08:15 pm"],
//                     ["Type":"Prospecting", "User":"Jack","Business":"PQR corp","Rating":"5","Timing":"04:15 pm"]
//
//    ]
    
    var MeetingContent = [Meeting]()
    
    
    
    
    //  *************** VIEWDIDLOAD ************************

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitTable.delegate = self
        visitTable.dataSource = self
        
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        
        let today = formatter.string(from: currentDate)
        
        NaviBarDate.text = today
        
        
        visitTable.allowsMultipleSelection = true
        
        let start_Timestamp = currentDate.timeIntervalSince1970
        
        // 00:00 till 23:59
        let end_Timestamp = start_Timestamp + 86340
        
        
        let apiLink  = appGlobalVariable.apiBaseURL+"visits/gettodayVisits?startdate=\(String(start_Timestamp))&userId=\(appGlobalVariable.userID)&enddate=\(String(end_Timestamp))"
        
        let paramKey : [String : Any] = ["userId": appGlobalVariable.userID,
                                         "startdate": String(start_Timestamp),
                                         "enddate": String(end_Timestamp)
        ]
        
        viewModel.getTodayVisitDetail(API: apiLink, Param: paramKey) { (status, err, Result) in
            
            print(Result?.count)
            if status == true{
            self.MeetingContent = Result!
                
                
                
                
                self.visitTable.reloadData()

            }
        }

        let calendarTap = UITapGestureRecognizer(target: self, action: #selector(calendarView))
        
        self.dateLabel.isUserInteractionEnabled = true
        self.dateLabel.addGestureRecognizer(calendarTap)
        

    }
    
    
    @objc func calendarView(){
        performSegue(withIdentifier: "Calendar", sender: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MeetingContent.count
    }
 
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

//        let cell = Bundle.main.loadNibNamed("VisitTableViewCell", owner: self, options: nil)?.first as! VisitTableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Visit", for: indexPath) as! VisitTableViewCell

        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
//
        
        
        var type = MeetingContent[indexPath.row].contactType
        
        if type == "Dealer"{
            
//            cell.topView.backgroundColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
            cell.topView.backgroundColor = UIColor(red: 0.517, green: 0.506, blue: 0.506, alpha: 1)

//            cell.typeLabel.textColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
            cell.typeLabel.textColor = UIColor.white
            
            cell.ratingStar.emptyStarColor = UIColor.lightGray
            cell.ratingStar.tintColor = UIColor.white
            

            cell.userNameLabel.textColor = UIColor.white
            cell.businessNameLabel.textColor = UIColor.white
            cell.timeLabel.textColor = UIColor.white
            cell.callNowButton.setImage(UIImage(named: "call_now_Dark"), for: .normal)
            
            cell.typeLabel.text = MeetingContent[indexPath.row].contactType
            cell.businessNameLabel.text = MeetingContent[indexPath.row].businessName
            cell.userNameLabel.text = MeetingContent[indexPath.row].contactName
           
            let rating = Int(MeetingContent[indexPath.row].rating ?? "0")
            let value = Double(exactly: rating!)
            cell.ratingStar.value = CGFloat(value!)
            
            cell.timeLabel.text = MeetingContent[indexPath.row].time
            
            
            cell.bottomStartButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
            cell.bottomDetailButton.addTarget(self, action: #selector(detailView), for: .touchUpInside)
            
        }
  
        else if type == "Lead" || type == "Client" || type == "Follow Up" || type == "Prospecting" {
            
        cell.topView.backgroundColor = UIColor.white

        cell.typeLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
            cell.ratingStar.emptyStarColor = UIColor.lightGray
            cell.ratingStar.tintColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
            
        cell.userNameLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
        cell.businessNameLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
        cell.timeLabel.textColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
            
            cell.typeLabel.text = MeetingContent[indexPath.row].purpose
            cell.businessNameLabel.text = MeetingContent[indexPath.row].businessName
            cell.userNameLabel.text = MeetingContent[indexPath.row].contactName
            
            let rating = Int(MeetingContent[indexPath.row].rating!)
            let value = Double(exactly: rating!)
            cell.ratingStar.value = CGFloat(value!)
            
            cell.timeLabel.text = MeetingContent[indexPath.row].time
            
            
            cell.bottomStartButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
            cell.bottomDetailButton.addTarget(self, action: #selector(detailView), for: .touchUpInside)

            
        }
 
        
        if self.selectedVisit.contains(indexPath.row){


           

        }
        else{


           
            visitTable.estimatedRowHeight = 160

        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell =  visitTable.cellForRow(at: indexPath) as! VisitTableViewCell

        
        let selected = self.selectedVisit.firstIndex(of: indexPath.row)
        
        if selected != nil{
            
            selectedVisit.remove(at: selected!)
            
            UIView.animate(withDuration: 0.3) {
                
                let type = self.MeetingContent[indexPath.row].contactType
                
                
                self.visitTable.reloadRows(at: [indexPath], with: .none)
                
                if type == "Dealer"{
                    
                    cell.topView.backgroundColor = UIColor(red: 0.517, green: 0.506, blue: 0.506, alpha: 1)
                    cell.typeLabel.textColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
                    cell.userNameLabel.textColor = UIColor.white
                    cell.businessNameLabel.textColor = UIColor.white
                    cell.timeLabel.textColor = UIColor.white
                    cell.callNowButton.setImage(UIImage(named: "call_now_Dark"), for: .normal)
                    
                    
                    
                }
                
            }
        }
        
        
        else{
        

                self.selectedVisit.append(indexPath.row)
        
                self.selected = indexPath.row

                cell.bottomStartButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
       
            visitCategory = MeetingContent[indexPath.row].contactType!
            
                UIView.animate(withDuration: 0.6) {
//
                            let type = self.MeetingContent[indexPath.row].contactType
            

            self.visitTable.reloadRows(at: [indexPath], with: .none)
           
                    if type == "Dealer"{
                
                cell.topView.backgroundColor = UIColor(red: 0.517, green: 0.506, blue: 0.506, alpha: 1)
                cell.typeLabel.textColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
                cell.userNameLabel.textColor = UIColor.white
                cell.businessNameLabel.textColor = UIColor.white
                cell.timeLabel.textColor = UIColor.white
                cell.callNowButton.setImage(UIImage(named: "call_now_Dark"), for: .normal)
                
                
                
            }
            
            }


        }
     
        print(selectedVisit)
        
        
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {



        
        
        if selectedVisit.contains(indexPath.row) {
            
            return 220
            
            
        }
            
        else {
            return 160
        }
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
        
        else if visitCategory == "Follow Up"{
            
            
            
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
