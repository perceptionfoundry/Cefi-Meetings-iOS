//
//  NewVisit.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 31/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class NewVisit: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate,contactdelegate,PurposeDelegate,contactContractDelegate, ReminderDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
  
    
    
    
   
    
    
    //  ****************  MAP STRUCTURE ****************
    
    struct meetup {
        var name : String
        var lat : Double = 0.0
        var long : Double = 0.0
    }
  
    
    
    //  ****************  OUTLET ****************
    @IBOutlet weak var contractView: UIView!
    
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var contractViewBottomLIne: UIView!
    @IBOutlet weak var contractViewHeight: NSLayoutConstraint!
    @IBOutlet weak var purposeTF: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var contractTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var reminderTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
    //  **************** VARIABLE  ****************

    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let datePicker = UIDatePicker()
    var date = Date()
    var date_stamp : TimeInterval?
    var time_Stamp : TimeInterval?
    var reminderTotalTime : Double = 0.0
    var viewModel = NewMeetingViewModel()
    var selectedContactName = ""
    var selectedContactID = ""
//    var selectedPurpose = ""
    var selectedContractID = ""
    var reminderOn = false
    var reminderTime : Double = 0.0
    var contractAvailable = false
    
    var segueStatus = false
    var dateValue : meetingDate!
    
    
    var pickerView = UIPickerView()
    var purposePicker = ["Prospecting", "Follow Up"]
    var reminderPicker = ["15 mins before", "30 mins before", "45 mins before", "60 mins before"]
    
    var selectedPurpose = "Prospecting"
    var selectedReminder = "15 mins before"
    
    var selectedTextField = ""
    
    // ******** VARIABLE RELATED TO MAP *********
    var chosenPlace : meetup?
    var contractId : String?
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    var mapCameraView: GMSMapView?
    
    
    
    //  **************** PROTOCOL FUNCTION  ****************

    func contactName(userName: String, id: String, ContractNumber: Bool?, businessName: String)  {
        contactTF.text = userName
        self.selectedContactID = id
        
        if ContractNumber ==  false{
            contractTF.text = "DEALER"
            contractTF.isUserInteractionEnabled = false
            contractViewHeight.constant = 0
            contractView.isHidden = true
            contractViewBottomLIne.isHidden = true
        }
        else{
            contractTF.text = ""

            contractTF.isUserInteractionEnabled = true
            contractViewHeight.constant = 60
            contractView.isHidden = false
            contractViewBottomLIne.isHidden = false

        }
    }
    
    func purposeValue(value: String) {
        self.purposeTF.text = value
    }
    
    
    func getContract(contractNumber :String, Value: String) {
        contractId = Value
        contractTF.text  = contractNumber
    }
    
    
    func reminderValue(minute : String , value: Double) {
        self.reminderTF.text = minute
        
        if value == 0 {
            reminderOn = false
        }
        else{
            reminderTime = value
            
            
            
            reminderOn = true
        }
    }
    
    
    
    
    //  **************** VIEWDIDLOAD  ****************

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        purposeTF.delegate = self
        reminderTF.delegate = self

        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        // Making navigation bar transparent
        naviBar.setBackgroundImage(UIImage(), for: .default)
        naviBar.shadowImage = UIImage()
        contactTF.text = selectedContactName
        contractTF.text = selectedContractID
//        purposeTF.text = selectedPurpose
        
        
        
        mapView.isHidden = true
        
        dateTF.delegate = self
        timeTF.delegate = self
        locationTF.delegate = self
        
        
        // testing purpose
        chosenPlace = meetup(name: "", lat: 0, long: 0)

        
        // Initialize device Current location delegate & respective functions
       
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 12)
        
        mapCameraView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
        
        self.mapCameraView!.animate(to: camera)
        
        self.mapView.addSubview(self.mapCameraView!)
        
        
        let contactButton = UITapGestureRecognizer(target: self, action: #selector(contactSegue))
        self.contactTF.addGestureRecognizer(contactButton)
        
//        let purposeButton = UITapGestureRecognizer(target: self, action: #selector(purposeSegue))
//        self.purposeTF.addGestureRecognizer(purposeButton)
//
//        let reminderButton = UITapGestureRecognizer(target: self, action: #selector(reminderSegue))
//        self.reminderTF.addGestureRecognizer(reminderButton)
        
        let contractButton = UITapGestureRecognizer(target: self, action: #selector(contractSegue))
        self.contractTF.addGestureRecognizer(contractButton)
        
//
    }
    
    
    
    //  ****************   CUSTOM SEGUE FUNCTION ****************

    @objc func reminderSegue(){
        performSegue(withIdentifier: "Reminder", sender: nil)

    }
    
    @objc func contactSegue(){
        performSegue(withIdentifier: "Contact", sender: nil)
    }
    
    @objc func purposeSegue(){
        performSegue(withIdentifier: "Purpose", sender: nil)
    }

    @objc func contractSegue(){
        
        if contactTF.text?.isEmpty == false {
            performSegue(withIdentifier: "Contract", sender: nil)

        }
        else{
            alert(Title: "Choose Contact", Message: "Please Select contact start")
        }

    }
    
    
    
    
    
    //  **************** VIEWWILLAPPEAR  ****************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    

    
    
    // ******************* SHOW DATE FUNCTION ***************************
    
    
    func showDatePicker(){
       
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        dateTF.inputAccessoryView = toolbar
        dateTF.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = datePicker.date
        
       
        
        dateTF.text = formatter.string(from: datePicker.date)
        
        let date_Stamp = formatter.date(from: dateTF.text!)?.timeIntervalSince1970

        self.date_stamp = date_Stamp
        
        self.reminderTotalTime +=  Double(date_Stamp!)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    // ******************* SHOW TIME FUNCTION ***************************
    
    
    func showTimePicker(){
        //Formate Date
        datePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        timeTF.inputAccessoryView = toolbar
        timeTF.inputView = datePicker
        
    }
    
    @objc func doneTimePicker(){
        
        self.reminderTotalTime = 0
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        date = datePicker.date
        
        
        
        timeTF.text = formatter.string(from: datePicker.date)
        
        self.reminderTotalTime = date.timeIntervalSince1970
        

        
        
        print(self.reminderTotalTime)

      

        print(self.reminderTotalTime)

        self.view.endEditing(true)
    }
    
    @objc func cancelTimePicker(){
        self.view.endEditing(true)
    }
    
    
    
    
    
    //  ****************  TEXTFIELD BEGIN EDITING ****************

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        

        
        if textField == dateTF{
            self.showDatePicker()
        }
            
        else if textField == timeTF{
            self.showTimePicker()
        }
            
        else if textField == purposeTF{
            
            self.pickerView.selectRow(0, inComponent: 0, animated: true)


            self.selectedTextField = "purpose"
            self.purposeTF.inputView = self.pickerView
            self.pickerView.reloadAllComponents()
            self.purposeTF.text = "Prospecting"
            
        }
            
        else if textField == reminderTF{
            self.selectedTextField = "reminder"

            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.reminderTF.inputView = self.pickerView
            self.pickerView.reloadAllComponents()
            self.reminderTF.text = "15 mins before"
            
        }
            
        
        else if textField == locationTF{
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        }

    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         if textField == purposeTF{
            
            self.purposeTF.inputView = nil
            self.pickerView.reloadAllComponents()
            
        }
            
        else if textField == reminderTF{
            
            self.reminderTF.inputView = nil
            self.pickerView.reloadAllComponents()
            
        }
    }
    
    
    
    // ******************* PREPARE SEUGUE FUNCTION ***************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
       
        
        
        if segue.identifier == "Contact"{
            
            let dest = segue.destination as! MainContactVC
            
            dest.contactDelegate = self
            dest.visitSegue = true
            
//            dest.segueStatus = true
        }
        
        else if segue.identifier == "Purpose"{
            
            let dest = segue.destination as! PurposeVC
            
            dest.previousSelected = purposeTF.text
            dest.purposeDelegate = self
        }
        
        else if segue.identifier == "Contract"{
            
            let dest = segue.destination as! ContractVC
            
            dest.contractDelegate = self
            dest.selectedUserID = self.selectedContactID
            dest.selectedUserName = self.contactTF.text!
        }
        
        else if segue.identifier == "Reminder"{
            
            let dest = segue.destination  as! ReminderVC
            dest.reminderDele = self
            dest.previousSelect = reminderTF.text ?? ""
        }
        
    
        
        
        
        
    }
  
    
    // PICKER DELEGATE FUNCTIONS
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.selectedTextField == "purpose"{
            return purposePicker.count
            
        }
        else {
            return reminderPicker.count
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if self.selectedTextField == "purpose"{
            return purposePicker[row]
            
            
        }
        else {
            return reminderPicker[row]
            
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        if self.selectedTextField == "purpose"{
            self.selectedPurpose = purposePicker[row]
            purposeTF.text = self.selectedPurpose
            
         

            
        }
        else {
          
            
            
            let selectedCell = row
            
            
            
            if selectedCell == 0{
                let timeStamp : Double = 15 * 60
                
                //            print(timeStamp)
                //            print(reminderdescrip[0])
                
                self.selectedReminder = reminderPicker[row]
                reminderTF.text = self.selectedReminder
                
                if timeStamp == 0 {
                    reminderOn = false
                }
                else{
                    reminderTime = timeStamp
                    
                    
                    
                    reminderOn = true
                }
              
            }
            else if selectedCell == 1{
                // min * (mill * sec)
                let timeStamp : Double = 30 * 60
                
                //            print(timeStamp)
                //            print(reminderdescrip[1])
                
                self.selectedReminder = reminderPicker[row]
                reminderTF.text = self.selectedReminder
                
                if timeStamp == 0 {
                    reminderOn = false
                }
                else{
                    reminderTime = timeStamp
                    
                    
                    
                    reminderOn = true
                }
                
                
            }
            else if selectedCell == 2{
                let timeStamp : Double = 45 * 60
                //            print(time)
                
                self.selectedReminder = reminderPicker[row]
                reminderTF.text = self.selectedReminder
                
                if timeStamp == 0 {
                    reminderOn = false
                }
                else{
                    reminderTime = timeStamp
                    
                    
                    
                    reminderOn = true
                }
                
            }
            else if selectedCell == 3{
                
                let timeStamp : Double = 60 * 60
                //            print(time)
                
                self.selectedReminder = reminderPicker[row]
                reminderTF.text = self.selectedReminder
                
                
                if timeStamp == 0 {
                    reminderOn = false
                }
                else{
                    reminderTime = timeStamp
                    
                    
                    
                    reminderOn = true
                }
            }
            else if selectedCell == 4{
                
                let timeStamp : Double = 60 * 60
                //            print(time)
                
                self.selectedReminder = reminderPicker[row]
                reminderTF.text = self.selectedReminder
                
                
                if timeStamp == 0 {
                    reminderOn = false
                }
                else{
                    reminderTime = timeStamp
                    
                    
                    
                    reminderOn = true
                }
                
            }
            
            
            
        }
        
    }

    
    
    // ********** SAVE BUTTON ACTION *******
   
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        
        if contactTF.text?.isEmpty == false && contractTF.text?.isEmpty == false && purposeTF.text?.isEmpty == false && dateTF.text?.isEmpty == false && timeTF.text?.isEmpty == false  {
        
            
           
            
            
        let apiLink = appGlobalVariable.apiBaseURL+"visits/addvisitdetails"
        
        
//        var timeStamp  = Date(timeIntervalSince1970: self.reminderTotalTime)
            
            var secondsFromGMT: Double { return Double(TimeZone.current.secondsFromGMT()) }
            
            var reminderADD : Double = 0.0
            
            
            print(reminderOn)
            
            print(reminderTotalTime)
            print(reminderTime)
            
            if reminderOn == true{
            
                reminderADD  = floor(reminderTotalTime + reminderTime) * 1000 + secondsFromGMT
//                reminderADD  = reminderTotalTime + reminderTime

            }
            
            

//            "time" : self.reminderTotalTime,

            
        let dictValue : [String : Any] = [
            
           
            "long": String(chosenPlace?.long ?? 0) ,
            "userId": appGlobalVariable.userID,
            "contactId": selectedContactID,
            "contractId": contractId ?? "DEALER",
            "time": String(Int((floor(self.reminderTotalTime) * 1000) + secondsFromGMT) ),
            "reminder": String(reminderADD) ,
            "lat": String(chosenPlace?.lat ?? 0),
            "address": chosenPlace?.name ?? "",
            "purpose": purposeTF.text!,
            "dateInString": dateTF.text!,
            "timeInString": timeTF.text!,
            "reminderinString" : reminderTF.text ?? "0 Min"
            

            

            
        ]
        
        print(dictValue)
            
            
            viewModel.newMeetingCreate(API: apiLink, Textfields: dictValue) { (status, err, resultData) in
                
                
                if status == false{
                    
                    self.alert(Title: "Server Error", Message: err!)
                }
                    
                    
                    
                else{
                    
                    if self.segueStatus == true{
                        
                        print(resultData)
                        
                        self.dateValue.setDate(Date: "Meeting \(self.dateTF.text!)", apiResult: resultData!)
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        
        
        }
        else{
            self.alert(Title: "Field Empty", Message: "Some of textfield is left empty")
        }
    }
    
    
    
    func alert(Title : String , Message : String){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    @IBAction func locationClearButton(_ sender: Any) {
        locationTF.text = ""
        mapView.isHidden = true
        chosenPlace = meetup(name: "", lat: 0, long: 0)
        
        print(chosenPlace)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
 

}


extension NewVisit: GMSAutocompleteViewControllerDelegate {
    
    // GOOGLE AUTOCOMPLETE DELEGATE FUNCTIONS
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        
        locationTF.text = place.formattedAddress
        
        
        chosenPlace = meetup(name: place.formattedAddress!, lat: lat, long: long )
        
        //        self.dismiss(animated: true, completion: nil)
        
        self.dismiss(animated: true) {
            
            
            let camera = GMSCameraPosition.camera(withLatitude: (self.chosenPlace?.lat)!, longitude: (self.chosenPlace?.long)!, zoom: 12)
            
            self.mapCameraView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
            
            
            self.mapCameraView!.animate(to: camera)
            
            
            
            let marker = GMSMarker(position: CLLocationCoordinate2DMake(self.chosenPlace!.lat, self.chosenPlace!.long))
        
            marker.title = "Meeting"
            marker.map = self.mapCameraView
            
            
            self.mapView.addSubview(self.mapCameraView!)

            self.mapView.isHidden = false
            
        }
        
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Autocomplete ERROR \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
