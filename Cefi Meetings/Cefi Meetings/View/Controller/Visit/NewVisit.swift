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


class NewVisit: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate,contactdelegate,PurposeDelegate,contactContractDelegate, ReminderDelegate{
   
    
    
    //  ****************  MAP STRUCTURE ****************
    
    struct meetup {
        var name : String
        var lat : Double
        var long : Double
    }
  
    
    
    //  ****************  OUTLET ****************

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
    var selectedContactID = ""
    var reminderOn = false
    var reminderTime : Double = 0.0
    var contractAvailable = false
    
    // ******** VARIABLE RELATED TO MAP *********
    var chosenPlace : meetup?
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    var mapCameraView: GMSMapView?
    
    
    //  **************** PROTOCOL FUNCTION  ****************

    func contactName(userName: String, id : String, ContractNumber : Bool?) {
        contactTF.text = userName
        self.selectedContactID = id
        
        if ContractNumber ==  false{
            contractTF.text = "DEALER"
            contractTF.isUserInteractionEnabled = false
        }
    }
    
    func purposeValue(value: String) {
        self.purposeTF.text = value
    }
    
    
    func getContract(Value: String) {
        contractTF.text = Value
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

        
        
        
        mapView.isHidden = true
        
        dateTF.delegate = self
        timeTF.delegate = self
        locationTF.delegate = self
        
        
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
        
        let purposeButton = UITapGestureRecognizer(target: self, action: #selector(purposeSegue))
        self.purposeTF.addGestureRecognizer(purposeButton)
        
        let reminderButton = UITapGestureRecognizer(target: self, action: #selector(reminderSegue))
        self.reminderTF.addGestureRecognizer(reminderButton)
        
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
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTF.inputAccessoryView = toolbar
        dateTF.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
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
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        timeTF.inputAccessoryView = toolbar
        timeTF.inputView = datePicker
        
    }
    
    @objc func doneTimePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        date = datePicker.date
        
        
        
        timeTF.text = formatter.string(from: datePicker.date)
        
        
        
        let separateTimeElement =  timeTF.text!.split(separator: ":")
        print(separateTimeElement)
        
        let hour_Stamp = (Double(separateTimeElement[0])! * 60 * 60)
        let min_Stamp = (Double(separateTimeElement[1])! * 60)
        
        let time_stamp = hour_Stamp + min_Stamp
        
        self.time_Stamp = time_stamp

//        print("hour: \(hour_Stamp), minute: \(min_Stamp), total: \(time_Stamp)")
        
        self.reminderTotalTime +=  time_stamp

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
            
        
        else if textField == locationTF{
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        }

    }
    
    
    
    
    // ******************* PREPARE SEUGUE FUNCTION ***************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "Contact"{
            
            let dest = segue.destination as! MainContactVC
            
            dest.contactDelegate = self
            dest.visitSegue = true
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
  
   
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        
        if contactTF.text?.isEmpty == false && contractTF.text?.isEmpty == false && purposeTF.text?.isEmpty == false && dateTF.text?.isEmpty == false && timeTF.text?.isEmpty == false && locationTF.text?.isEmpty == false {
        
        let apiLink = appGlobalVariable.apiBaseURL+"visits/addvisitdetails"
        
        
//        var timeStamp  = Date(timeIntervalSince1970: self.reminderTotalTime)
            
            var reminderADD : Double = 0.0
            if reminderOn == true{
            
                reminderADD  = floor(reminderTotalTime + reminderTime) * 1000
//                reminderADD  = reminderTotalTime + reminderTime

            }
            
            

//            "time" : self.reminderTotalTime,

            
        let dictValue : [String : Any] = [
            
            "userId" : appGlobalVariable.userID,
            "contactId" : selectedContactID,
            "contractId" : contractTF.text!,
            "time" : String(Int(floor(self.reminderTotalTime) * 1000)),
            "reminder" : String(reminderADD),
            "lat" : String(chosenPlace!.lat),
            "long" : String(chosenPlace!.long),
            "address" : chosenPlace!.name,
            "purpose" : purposeTF.text!
            
        ]
        
        print(dictValue)
            
            
            viewModel.newMeetingCreate(API: apiLink, Textfields: dictValue) { (status, err) in
                
                
                if status == false{
                    
                    self.alert(Title: "Server Error", Message: err!)
                }
                    
                    
                    
                else{
                    
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
