//
//  NewContactVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class NewContactVC: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate{
    
    
    struct meetup {
        var name : String
        var lat : Double
        var long : Double
    }
    
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var businessTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var industryTF: UITextField!
    @IBOutlet weak var referredTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
    
    
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var apiLink = ""
    let viewModel = NewContactViewModel()
    
    var chosenPlace : meetup?
    
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    
    
    var mapCameraView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.apiLink = "\(appGlobalVariable.apiBaseURL)contacts/addcontact"

        
        
        mapView.isHidden = true
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
        
        

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        // ********* parameter that are required by API ************
        let newContactParameter = ["userId" : "",
                                    "businessName" : businessTF.text,
                                     "contactName" : contactTF.text,
                                    "phoneNumber" : phoneTF.text,
                                    "email" : emailTF.text,
                                    "industryType" : industryTF.text,
                                    "contactType" : contactTF.text,
                                    "referredBy" : referredTF.text,
                                    "lat" : self.chosenPlace?.lat,
                                    "long" : chosenPlace?.long                                    ] as [String : Any]
        
        
        
        
        
        
        
        
        //  *************** Verifying both textfield is not left empty ***********
        if businessTF.text?.isEmpty == false && contactTF.text?.isEmpty == false && phoneTF.text?.isEmpty == false && emailTF.text?.isEmpty == false && industryTF.text?.isEmpty == false && contactTF.text?.isEmpty == false && referredTF.text?.isEmpty == false && locationTF.text?.isEmpty == false{
            
            
            
            
            // ****** Hitting ApiLink with required parameter **********
            
            viewModel.newContactCreate(API: self.apiLink, Textfields: newContactParameter) { (status, err) in
                
                
                
                if status == false{
                    
                    self.alertMessage(Title: "Sign In Error", Message: err!)
                }
                    
                    
                    
                else{
                    self.performSegue(withIdentifier: "Dashboard", sender: nil)
                }
                
                
            }
            
        }
            
        else{
            self.alertMessage(Title: "TextField Empty", Message: "Some of textfield is left empty")
        }
        
    }
    
    
    // ******* Function that will handle Alert Viewcontroller ************
    
    
    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func contractDetailAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contract_Detail")
        //        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension NewContactVC: GMSAutocompleteViewControllerDelegate {
    
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

