//
//  VisitDetailVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 01/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MessageUI


class VisitDetailVC: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate,ReminderDelegate{
   
    
    
    func reminderValue(minute: String, value: Double) {
        
        self.reminderTF.text = minute
        
        if value == 0 {
            reminderOn = false
        }
        else{
            reminderTime = value
            reminderOn = true
        }
    }
    
    
    
    struct meetup {
        var name : String
        var lat : Double
        var long : Double
    }
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var contactTF: UILabel!
    @IBOutlet weak var contractTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var reminderTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
    @IBOutlet weak var editButton: Custom_Button!

    var date = Date()
    let datePicker = UIDatePicker()
    var date_stamp : TimeInterval?
    var time_Stamp : TimeInterval?
    var reminderTotalTime : Double = 0.0
    var reminderOn = false
    var reminderTime : Double = 0.0
    var meetingDetail : Meeting?
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let getContractViewModel = GetSpecificContractViewModel()
    let editVisitViewModel = EditVisitViewModel()

    
    // ******** Map related Variable *********
    var chosenPlace : meetup?
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    var mapCameraView: GMSMapView?
    
    var secondsFromGMT: Double { return Double(TimeZone.current.secondsFromGMT()) }

    
    
    var editOn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let reminderButton = UITapGestureRecognizer(target: self, action: #selector(reminderSegue))
        self.reminderTF.addGestureRecognizer(reminderButton)
        
     
        
        print(meetingDetail!)
        
        
        // Convert existing server timestamp formot into iOS timestamp format (REVERSE)


        
        let iOSTimeStamp = (((meetingDetail!.time! as NSString).doubleValue) - secondsFromGMT) / 1000
        
        self.reminderTotalTime  = iOSTimeStamp
        
        print(iOSTimeStamp)
        
        let dateString = meetingDetail!.addedDate!.split(separator: "T")
        
        
        
        let reminderString = meetingDetail!.reminder!
        
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: TimeZone.current.identifier)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: reminderString)!
        dateFormatter.dateFormat = "hh:MM a" ; //"dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale --> but no need here
        let newString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(newString)")
        
        
        
        let time1 = meetingDetail?.timeInString!
        let time2 = newString
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        
        let date1 = formatter.date(from: time1!)!
        let date2 = formatter.date(from: time2)!
        
        let elapsedTime = date2.timeIntervalSince(date1)
        
        // convert from seconds to hours, rounding down to the nearest hour
        let hours = floor(elapsedTime / 60 / 60)
        
        // we have to subtract the number of seconds in hours from minutes to get
        // the remaining minutes, rounding down to the nearest minute (in case you
        // want to get seconds down the road)
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        
        print("\(Int(hours)) hr and \(Int(minutes)) min")
        
 
       
        contactTF.text = meetingDetail!.contactName!
        contractTF.text = meetingDetail!.contractNumber
        dateTF.text = String(dateString[0])
//        timeTF.text = timeString
        timeTF.text = meetingDetail!.timeInString
//        reminderTF.text = meetingDetail!.reminder!
        reminderTF.text = "\(Int(minutes)) Minutes"
        
        
        let lat = (meetingDetail!.lat! as NSString).doubleValue
        let long  = (meetingDetail!.longField! as NSString).doubleValue
        
        
        var dateTimeArray = [String]()
        
       
        
        
        self.getAddressFromLatLon(pdblLatitude: meetingDetail!.lat!, withLongitude: meetingDetail!.longField!) { (place) in
            
            self.locationTF.text = place!
            self.chosenPlace?.name = place!
            self.chosenPlace = meetup(name: place!, lat: lat, long: long)
            
            
        }
    
        
        contractTF.isEnabled = false
        dateTF.isEnabled = false
        timeTF.isEnabled = false
        reminderTF.isEnabled = false
        locationTF.isEnabled = false
        
        

        //        mapView.isHidden = true
        locationTF.delegate = self
        dateTF.delegate = self
        timeTF.delegate = self
        
        
        
        // Initialize device Current location delegate & respective functions
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 12)
        
        mapCameraView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
        
        self.mapCameraView!.animate(to: camera)
        
        self.mapView.addSubview(self.mapCameraView!)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    // Function Fetch Place value
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String,completion:@escaping(_ location:String?)->Void) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    completion(nil)
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    
//                    print(addressString)
                    completion(addressString)
                }
        })
        
    }
    
    
    
    
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
    
    
    @IBAction func contractDetailAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contract_Detail")
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func callButtonAction(_ sender: Any) {
        
        //*********************** CALLING FUNCTION *********************
       
            
            
        let number = String(meetingDetail!.phoneNumber!)
        print(number)
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
    
    @IBAction func messageButtonAction(_ sender: UIButton) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [String(meetingDetail!.phoneNumber!)]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func editButtonAction(_ sender: Any) {
       
        
 
        
        
        if editOn == false{
            editOn = true
            editButton.backgroundColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
            
            editButton.shadowOpacity = 10
            editButton.shadowRadius = 2
            editButton.shadowColor = UIColor.darkGray
            dateTF.isEnabled = true
            timeTF.isEnabled = true
            reminderTF.isEnabled = true
            locationTF.isEnabled = true
        }
        
        else{
            editOn = false
            editButton.backgroundColor = UIColor.clear
            editButton.shadowOpacity = 0
            editButton.shadowRadius = 0
            
            contractTF.isEnabled = false
            dateTF.isEnabled = false
            timeTF.isEnabled = false
            reminderTF.isEnabled = false
            locationTF.isEnabled = false
            
            let apiLink = appGlobalVariable.apiBaseURL+"visits/updatevisit"
            
            
            
            var reminderADD : Double = 0.0
            if reminderOn == true{
                
                reminderADD  = floor(reminderTotalTime + reminderTime) * 1000 + secondsFromGMT
            
            }
            
            
            let paramDict : [String : Any] = [
                "visitId" : meetingDetail!.id!,
                "long": String(chosenPlace!.long),
                "userId": appGlobalVariable.userID,
                "contactId": meetingDetail!.contactId!,
                "contractId": meetingDetail!.contractId ?? "DEALER",
                "time":  String(Int((floor(self.reminderTotalTime) * 1000) + secondsFromGMT) ),
                "reminder": reminderADD,
                "lat": String(chosenPlace!.lat),
                "address": chosenPlace!.name,
                "purpose": meetingDetail!.purpose!,
                "dateInString": dateTF.text!,
                "timeInString": timeTF.text!,
            
            ]
            
            print(paramDict)

            editVisitViewModel.editVisit(API: apiLink, Textfields: paramDict) { (status, error) in
                
                print(status)
            }
        }
//
       
        
        
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
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        timeTF.inputAccessoryView = toolbar
        timeTF.inputView = datePicker
        
    }
    
    @objc func doneTimePicker(){
        
        self.reminderTotalTime = 0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        date = datePicker.date
        
        
        
        timeTF.text = formatter.string(from: datePicker.date)
        
        
        
        let separateTimeElement =  timeTF.text!.split(separator: ":")
        //        print(separateTimeElement)
        
        let timeWithoutPM = separateTimeElement[1].split(separator: " ")
        print(timeWithoutPM)
        
        let hour_Stamp = (Double(separateTimeElement[0])! * 60 * 60)
        let min_Stamp = (Double(timeWithoutPM[0])! * 60)
        
        let time_stamp = hour_Stamp + min_Stamp
        
        self.time_Stamp = time_stamp
        
                print("hour: \(hour_Stamp), minute: \(min_Stamp), total: \(time_Stamp)")
        
        print(self.reminderTotalTime)

        
        self.reminderTotalTime +=  time_stamp
        
        print(self.reminderTotalTime)
        
        self.view.endEditing(true)
    }
    
    
    
    @objc func cancelTimePicker(){
        self.view.endEditing(true)
    }
    
    
    //
    @objc func reminderSegue(){
        performSegue(withIdentifier: "Reminder", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
     
            
        if segue.identifier == "Reminder"{
            
            let dest = segue.destination  as! ReminderVC
            dest.reminderDele = self
            dest.previousSelect = reminderTF.text ?? ""
        }
        
        
        
        
        
        
    }
    
    
}


extension VisitDetailVC: GMSAutocompleteViewControllerDelegate {
    
    // GOOGLE AUTOCOMPLETE DELEGATE FUNCTIONS
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        
        locationTF.text = place.formattedAddress
        
        
        chosenPlace = meetup(name: place.formattedAddress!, lat: lat, long: long )
        
        
        self.dismiss(animated: true) {

            
        }
        
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Autocomplete ERROR \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

