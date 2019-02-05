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


class VisitDetailVC: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate{
    
    
    struct meetup {
        var name : String
        var lat : Double
        var long : Double
    }
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var contractTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var reminderTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
    @IBOutlet weak var editButton: Custom_Button!
    @IBOutlet weak var detailButton_Y_Constraint: NSLayoutConstraint!
    
    
    var chosenPlace : meetup?
    
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    
    
    var editOn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contractTF.isEnabled = false
        dateTF.isEnabled = false
        timeTF.isEnabled = false
        reminderTF.isEnabled = false
        locationTF.isEnabled = false
        
        
//        mapView.isHidden = true
        locationTF.delegate = self
        
        
        // Initialize device Current location delegate & respective functions
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
      
        
        
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func contractDetailAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contract_Detail")
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
       
        if editOn == false{
            editOn = true
            editButton.backgroundColor = UIColor(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
            
            editButton.shadowOpacity = 10
            editButton.shadowRadius = 2
            editButton.shadowColor = UIColor.darkGray
            contractTF.isEnabled = true
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
        
        //        self.dismiss(animated: true, completion: nil)
        
        self.dismiss(animated: true) {
            
//            self.mapView.isHidden = false
//            self.detailButton_Y_Constraint.constant = 0
            
        }
        
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Autocomplete ERROR \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

