//
//  MainMeetingVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

protocol calenderDelegate {
    func selectDate (selectedDateValue: String, NaviDate: String)
}

class MainMeetingVC: UIViewController, UITableViewDelegate, UITableViewDataSource, calenderDelegate {
    
    
    func selectDate(selectedDateValue: String, NaviDate: String) {
        self.MeetingContent.removeAll()
        print(selectedDateValue)

        
        self.dateString = selectedDateValue
        NaviBarDate.text = NaviDate
//        getMeeting()
    }
    

    
    
    
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
    var MeetingContent = [Meeting]()
    var selectedContact : Meeting?
    var dateString = ""
    
    var selectedDate = Date()
    var selectedTagNumber = 0
    
    
    
    //  *************** VIEWDIDLOAD ************************

    
    override func viewDidLoad() {
              super.viewDidLoad()
        
        
        
        
        let startDateOfTodayFormatter: DateFormatter = DateFormatter()
        startDateOfTodayFormatter.dateFormat = "yyyy-MM-dd"
        self.dateString = startDateOfTodayFormatter.string(from: selectedDate)
        
        
  
        
        visitTable.delegate = self
        visitTable.dataSource = self
        
        let currentDate = Date()
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        let today = formatter.string(from: currentDate)
        
        NaviBarDate.text = today
        
        
        visitTable.allowsMultipleSelection = true
        


        let calendarTap = UITapGestureRecognizer(target: self, action: #selector(calendarView))
        
        self.dateLabel.isUserInteractionEnabled = true
        self.dateLabel.addGestureRecognizer(calendarTap)
        

    }
    
    
    
    
    
    
    
    func getStartAndEndDate()->(startDate:Double,endDate:Double){
        let currentTime = self.selectedDate
        let currentDateFormatter: DateFormatter = DateFormatter()
        currentDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDateOfTodayFormatter: DateFormatter = DateFormatter()
        startDateOfTodayFormatter.dateFormat = "yyyy-MM-dd"
        
        
//       self.dateString = startDateOfTodayFormatter.string(from: currentTime)
        
        let startDate = startDateOfTodayFormatter.date(from: self.dateString)

        
        var secondsFromGMT: Double { return Double(TimeZone.current.secondsFromGMT()) }
        
        let endtimestamp:Double = (startDate?.timeIntervalSince1970)! + 86499
        
        let endTime = Date(timeIntervalSince1970: endtimestamp)
        
        let startTimeStampForServer = (startDate?.timeIntervalSince1970)! + secondsFromGMT
        
        let endTimestampForServer = endTime.timeIntervalSince1970 + secondsFromGMT
        
        return(startTimeStampForServer,endTimestampForServer)
    }
    
    
    
    
    
    // ****************** VIEWMODEL FUNCTION  ***************************

    
    
    func getMeeting(){

        let timeValue = getStartAndEndDate()
//        let currentDate = Date()
//
        let start_Timestamp = timeValue.startDate

        // 00:00 till 23:59
        let end_Timestamp = timeValue.endDate
        
        
        let apiLink  = appGlobalVariable.apiBaseURL+"visits/gettodayVisits?userId=\(appGlobalVariable.userID)&startdate=\(self.dateString)&enddate=\(String(Int(floor(end_Timestamp * 1000))))"
        
        print(apiLink)
        let startDate = Date(timeIntervalSince1970: start_Timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startTime = dateFormatter.string(from: startDate)
        let paramKey : [String : Any] = ["userId": appGlobalVariable.userID,
                                         "startdate": startTime,
                                         "enddate": String(Int(floor(end_Timestamp * 1000)))
        ]
        
//        print(paramKey)
        
        viewModel.getTodayVisitDetail(API: apiLink, Param: paramKey) { (status, err, Result) in
            
        
            
            if status == true{
                self.MeetingContent.removeAll()

                self.MeetingContent = Result!
             
                self.visitTable.reloadData()
                
            }
            else{
                self.MeetingContent.removeAll()
                self.visitTable.reloadData()
            }
        }
        
    }
    

    
    
    
    
    
    
    // ********** SEGUE TO CALENDAR ***********
    
    @objc func calendarView(){
        performSegue(withIdentifier: "Calendar", sender: nil)
    }
    
    
    
    
    
    
    
    // ********** VIEW WILL APPEAR ***********

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.tabBarController?.tabBar.isHidden = false

        self.getMeeting()
    }
    
    
    

    
    // ********** TABLE VIEW PROTOCOL FUNCTIONS ***********

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MeetingContent.count
    }
 
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Visit", for: indexPath) as! VisitTableViewCell

        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        cell.completedLabel.isHidden = true
//
        
        
        let type = MeetingContent[indexPath.row].contactType
        let purpose = MeetingContent[indexPath.row].purpose
        
        // DECISION W.R.T "TYPE
        
        
        
        if type == "Dealer"{
            
//            cell.topView.backgroundColor = UIColor(red: 0.517, green: 0.506, blue: 0.506, alpha: 1)
            cell.topView.backgroundColor = UIColor(red: 0.129, green: 0.277, blue: 0.031, alpha: 1)

//            cell.typeLabel.textColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
            cell.typeLabel.textColor = UIColor(red: 0.440, green: 0.695, blue: 0.212, alpha: 1.0)
            
            cell.ratingStar.emptyStarColor = UIColor.lightGray
            cell.ratingStar.tintColor = UIColor(red: 0.440, green: 0.695, blue: 0.212, alpha: 1.0)
            

            cell.userNameLabel.textColor = UIColor.white
            cell.businessNameLabel.textColor = UIColor.white
            cell.timeLabel.textColor = UIColor.white
            cell.callNowButton.setImage(UIImage(named: "call_now_light"), for: .normal)
            
            cell.typeLabel.text = MeetingContent[indexPath.row].contactType
            cell.businessNameLabel.text = MeetingContent[indexPath.row].businessName
            cell.userNameLabel.text = MeetingContent[indexPath.row].contactName
            
            
            if MeetingContent[indexPath.row].visitStatus == "Completed"{
                cell.completedLabel.textColor = UIColor.white
                cell.completedLabel.isHidden = false
                cell.callNowButton.isHidden = true

            }
            
            cell.callNowButton.tag = indexPath.row
            cell.callNowButton.addTarget(self, action: #selector(dialNumber), for: .touchUpInside)

            
            let rating = Int(MeetingContent[indexPath.row].rating ?? "0")
            let value = Double(exactly: rating!)
            cell.ratingStar.value = CGFloat(value!)
            

            
            
            cell.timeLabel.text = MeetingContent[indexPath.row].timeInString
            
            cell.bottomStartButton.tag = indexPath.row
            cell.bottomDetailButton.tag = indexPath.row
            
            // ADDING ACTION TO BUTTONS

            cell.bottomStartButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
            cell.bottomDetailButton.addTarget(self, action: #selector(detailView), for: .touchUpInside)
            
        }
  
            
            
        else{
            if purpose == "Prospecting" || purpose == "Follow Up"  {
            
        cell.topView.backgroundColor = UIColor.white

        cell.typeLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
        cell.ratingStar.emptyStarColor = UIColor.lightGray
        cell.ratingStar.tintColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
            
        cell.userNameLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
        cell.businessNameLabel.textColor = UIColor(red: 0.055, green: 0.253, blue: 0.012, alpha: 1.0)
        cell.timeLabel.textColor = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
                cell.callNowButton.setImage(UIImage(named: "call_now_Dark"), for: .normal)

            cell.typeLabel.text = MeetingContent[indexPath.row].purpose
            cell.businessNameLabel.text = MeetingContent[indexPath.row].businessName
            cell.userNameLabel.text = MeetingContent[indexPath.row].contactName
            
                if MeetingContent[indexPath.row].visitStatus == "Completed"{
                    cell.completedLabel.textColor =  UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1.0)
                    cell.completedLabel.isHidden = false
                    cell.callNowButton.isHidden = true
                    
                }
                
                
        cell.callNowButton.tag = indexPath.row
        cell.callNowButton.addTarget(self, action: #selector(dialNumber), for: .touchUpInside)
            
            let rating = Int(MeetingContent[indexPath.row].rating ?? "0")
            let value = Double(exactly: rating!)
            cell.ratingStar.value = CGFloat(value!)
            
            
//
            
            cell.timeLabel.text = MeetingContent[indexPath.row].timeInString
            
                
            cell.bottomStartButton.tag = indexPath.row
            cell.bottomDetailButton.tag = indexPath.row

            cell.bottomStartButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
            cell.bottomDetailButton.addTarget(self, action: #selector(detailView), for: .touchUpInside)

            }
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

        
        // Store current selected user
//        self.selectedContact =  MeetingContent[indexPath.row]

        
        let selected = self.selectedVisit.firstIndex(of: indexPath.row)
        
        if selected != nil{
            
            selectedVisit.remove(at: selected!)
            
            UIView.animate(withDuration: 0.3) {
                
                let type = self.MeetingContent[indexPath.row].contactType
                
                
                self.visitTable.reloadRows(at: [indexPath], with: .none)
               
                
                
                
                // DECISION W.R.T TO "TYPE"
                
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
        
        
        else {
        

                self.selectedVisit.append(indexPath.row)
        
                self.selected = indexPath.row

//        
//            }
            
                UIView.animate(withDuration: 0.6) {

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
     
//        print(selectedVisit)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {



        
        if selectedVisit.contains(indexPath.row) {
        
            return 220
            
            
        }
            
        else {
            return 160
        }
    }
    
    
    //*********************** CALLING FUNCTION *********************
    @objc func dialNumber(button: UIButton) {
        
    
        let number = String(MeetingContent[button.tag].phoneNumber!)
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    
    // ******************** SWITCH TO START MEETING FUNCTION **********************************

    
    @objc func startMeeting(button : UIButton){
     
        if MeetingContent[button.tag].contactType != "Dealer"{
            
            visitCategory = MeetingContent[button.tag].purpose!
        }
        else{
            visitCategory = MeetingContent[button.tag].contactType!
        }
        print(visitCategory)
        self.selectedContact =  MeetingContent[button.tag]
        print(button.tag)
        print(selectedContact)
        
        if visitCategory == "Prospecting"{
            
            let storyboard = UIStoryboard(name: "Visit", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Prospecting") as! ProspectingVC
            vc.meetingDetail = self.selectedContact!
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        else if visitCategory == "Dealer"{
            
            let storyboard = UIStoryboard(name: "Visit", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Dealer") as! DealerVC
            vc.meetingDetail = self.selectedContact!
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else if visitCategory == "Client" {
            
            let storyboard = UIStoryboard(name: "Visit", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Client") as! ClientVC
            vc.meetingDetail = self.selectedContact!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if visitCategory == "Follow Up" || visitCategory == "Lead"{
   
            let storyboard = UIStoryboard(name: "Visit", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Follow_Up") as! FollowUpVC
            vc.meetingDetail = self.selectedContact!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
       
        
    }
    
    
    
    
    
    
    // ******************** VIEW MEETING DETAIL FUNCTION **********************************

    @objc func detailView(button : UIButton){
     
        
        print(button.tag)
        
        self.selectedContact =  MeetingContent[button.tag]

        
        performSegue(withIdentifier: "Meeting_Detail", sender: nil)

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Meeting_Detail"{
        
        let dest = segue.destination as! VisitDetailVC
        dest.meetingDetail = self.selectedContact!
        }
        
        else if segue.identifier == "Calendar"{
            
            let dest = segue.destination as! CalendarVC
            
            dest.calendarDele = self
            
        }
    }
    
    
    
    
    
    
    
    
    // ******************** ADD BUTTON FUNCTION **********************************
    
    @IBAction func addButtonAction(_ sender: Any) {
        
        let storyboardRef =  UIStoryboard(name: "Visit", bundle: nil)
        
        let vc = storyboardRef.instantiateViewController(withIdentifier: "New_Visit")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
