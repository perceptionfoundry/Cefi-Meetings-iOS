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


class NewVisit: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate,contactdelegate,PurposeDelegate,contactContractDelegate{
   
    
    struct meetup {
        var name : String
        var lat : Double
        var long : Double
    }
  
    
    @IBOutlet weak var purposeTF: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var contractTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var reminderTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
        let datePicker = UIDatePicker()
        var date = Date()

    
    var selectedContactID = ""
    
    // ******** Map related Variable *********
    var chosenPlace : meetup?
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    var mapCameraView: GMSMapView?
    
    
    
    func contactName(userName: String, id : String) {
        contactTF.text = userName
        self.selectedContactID = id
    }
    
    func purposeValue(value: String) {
        self.purposeTF.text = value
    }
    
    
    func getContract(Value: String) {
        contractTF.text = Value
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        mapView.isHidden = true
        
        dateTF.delegate = self
        timeTF.delegate = self
//        contactTF.delegate = self
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
        
        
        let contractButton = UITapGestureRecognizer(target: self, action: #selector(contractSegue))
        self.contractTF.addGestureRecognizer(contractButton)
        
//
    }
    
    
    @objc func contactSegue(){
        performSegue(withIdentifier: "Contact", sender: nil)
    }
    
    @objc func purposeSegue(){
        performSegue(withIdentifier: "Purpose", sender: nil)
    }
    
    
    
    @objc func contractSegue(){
        performSegue(withIdentifier: "Contract", sender: nil)

    }
        
        
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
        formatter.dateFormat = "hh:mm:ss"
        date = datePicker.date
        timeTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelTimePicker(){
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        if textField == contactTF{
//
//
//            performSegue(withIdentifier: "Contact", sender: nil)
//
////            let storyboard = UIStoryboard(name: "Main", bundle: nil)
////
////            let vc = storyboard.instantiateViewController(withIdentifier: "Contact")
////            self.navigationController?.pushViewController(vc, animated: true)
//
//
//        }
        
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
            dest.segueStatus = true
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
