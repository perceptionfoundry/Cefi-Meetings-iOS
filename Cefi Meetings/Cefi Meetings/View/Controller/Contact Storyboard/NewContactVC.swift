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


class NewContactVC: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate, typeDelegate, equipmentTypeDelegate, contactdelegate{
  
    
    func typeName(labelName: String, serverName: String) {
        typeTF.text = serverName

    }
    
    
    
    func contactName(userName: String, id: String, ContractNumber: Bool?, businessName: String) {
        referredTF.text = userName
        referredID = id
        
        
    }
    
    
    
    
    
    
    
    // ****************** PROTOCOL FUNCTIONS *****************

    func equipmentType(list: [String]) {
        
        self.industryValue = list
        
        if list.count > 1{
            
            let text = "\(list[0]), \(list.count - 1) more"
            industryTF.text = text
        }
        else if list.count == 1{
            industryTF.text = list[0]
        }
    }
    
    
    
//    func typeName(name: String) {
//        typeTF.text = name
//    }
    
    
    
    
 
    // ****************** AUTO COMPLETE PLACE STRUCT *****************

    
    
    struct meetup {
        var name : String
        var lat : Double
        var long : Double
    }
    
    
    
    
    
    
    // ****************** OUTLET *****************

    
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var typeTF: UITextField!
    @IBOutlet weak var businessTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var industryTF: UITextField!
    @IBOutlet weak var referredTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    
    
    // ****************** VARIABLE *****************

    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var apiLink = ""
    let viewModel = NewContactViewModel()
    var industryValue = [String]()
    var referrredName = ""
    var referredID : String?
    var visitID = ""

    
    var SegueField = ""
    
    //  Map related Variable
    var chosenPlace : meetup?
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    var mapCameraView: GMSMapView?
    
    
    
    
    
    
    
    // ****************** VIEWDIDLOAD *****************

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTF.delegate = self
        mainViewHeight.constant = 600
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Avenir Black", size: 21)!]
        
        // Making navigation bar transparent
        naviBar.setBackgroundImage(UIImage(), for: .default)
        naviBar.shadowImage = UIImage()
        
        
        self.apiLink = "\(appGlobalVariable.apiBaseURL)contacts/addcontact"

        
        
        mapView.isHidden = true
        locationTF.delegate = self
        typeTF.delegate = self
        referredTF.delegate = self
        industryTF.delegate = self
    
        
        
        // Initialize device Current location delegate & respective functions
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    
        let camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 12)
        
        mapCameraView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)

        self.mapCameraView!.animate(to: camera)
        
        self.mapView.addSubview(self.mapCameraView!)
        
        if referrredName != ""{
            referredTF.isUserInteractionEnabled = false
            
        }
        
        referredTF.text = referrredName
        
        let typeTFTap = UITapGestureRecognizer(target: self, action: #selector(selectType))
        
        typeTF.addGestureRecognizer(typeTFTap)
        
        let industryTFTap = UITapGestureRecognizer(target: self, action: #selector(industriesType))
        
        industryTF.addGestureRecognizer(industryTFTap)
        
        let referredTFTap = UITapGestureRecognizer(target: self, action: #selector(reffered))
        
        referredTF.addGestureRecognizer(referredTFTap)
        
        
    }
    
    
    
    
    
    
    
    // ****************** VIEW WILL APPEAR ***************************

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    
    // ********** EMAIL VALIDATION *****************
    
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    // ****************** OUTLET CUSTOM ACTION FUNCTION *****************

    
    @objc func selectType(){
        SegueField = "Contact"
        performSegue(withIdentifier: "Contact_Type", sender: nil)
    }
  
    @objc func industriesType(){
        performSegue(withIdentifier: "Industry_Type", sender: nil)
        
        
    }
    
    @objc func reffered(){
    
        self.SegueField = "Reffered"
    self.performSegue(withIdentifier: "Contact", sender: nil)
    }
    
    
    
    
    
    // ****************** TEXTFIELD BEGIN EDIT FUNCTION *****************

   
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
      
        
        if textField == locationTF {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
        }
        
//        else if textField == referredTF{
//
//
//                SegueField = "Reffered"
//                performSegue(withIdentifier: "Contact", sender: nil)
//
//
//
//        }
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if emailTF.text?.count == 25{
            
            
            emailTF.endEditing(true)
            let alert = UIAlertController(title: "Alert", message: "You have entered INVALID email address", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        return true
    }
    
    
    
    
    
    // ****************** SAVE BUTTON FUNCTION *****************

    @IBAction func saveButtonAction(_ sender: Any) {
        
        
     
        
        
        
        
        
        
        
        
        //   Verifying both textfield is not left empty
        if businessTF.text?.isEmpty == false && contactTF.text?.isEmpty == false && phoneTF.text?.isEmpty == false && emailTF.text?.isEmpty == false && industryTF.text?.isEmpty == false && contactTF.text?.isEmpty == false && locationTF.text?.isEmpty == false{
            
            
            if isValidEmail(emailID: emailTF.text!) && emailTF.text!.count < 26{
                
         
            
            
            //  parameter that are required by API
            let newContactParameter = ["userId" : appGlobalVariable.userID,
                                       "businessName" : businessTF.text!,
                                       "contactName" : contactTF.text!,
                                       "phoneNumber" : phoneTF.text!,
                                       "email" : emailTF.text!,
                                       "industryType" : self.industryValue,
                                       "contactType" : typeTF.text!,
                                       "referredBy" : referredTF.text ?? "none",
                                       "lat" : self.chosenPlace!.lat,
                                       "long" : chosenPlace!.long,
                                       "visitId" : self.visitID
                ] as [String : Any]
            
            
            //  Hitting ApiLink with required parameter
            
            viewModel.newContactCreate(API: self.apiLink, Textfields: newContactParameter) { (status, err) in
                
                
                
                if status == false{
                    
                    self.alertMessage(Title: "Sign In Error", Message: err!)
                }
                    
                    
                    
                else{
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            }
            
        }
            
            else{
                let alert = UIAlertController(title: "Alert", message: "You have entered INVALID email address", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
            }
        }
            
        else{
            self.alertMessage(Title: "TextField Empty", Message: "Some of textfield is left empty")
        }
        
    }
    
    
    //  Function that will handle Alert Viewcontroller
    
    
    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    // ****************** CONTRACT DETAIL BUTTON ACTION FUNCTION *****************

    
    @IBAction func contractDetailAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contract_Detail")
        //        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    
    // ****************** CANCEL BUTTON ACTION FUNCTION *****************

    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}



// ****************** EXTENSION *****************


extension NewContactVC: GMSAutocompleteViewControllerDelegate {
    
    // ************** GOOGLE AUTOCOMPLETE DELEGATE FUNCTIONS ************************
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
            
            marker.title = self.contactTF.text!
            marker.map = self.mapCameraView
            
            
            self.mapView.addSubview(self.mapCameraView!)
            
            
            
            self.mapView.addSubview(self.mapCameraView!)
            
            self.mainViewHeight.constant = 800

            self.mapView.isHidden = false
            
        }
        
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Contact_Type"{
            
            let dest = segue.destination  as! contactType
            
            dest.typeDelegate = self
            dest.previousSelected = typeTF.text
        }
        
        else if segue.identifier == "Industry_Type"{
            let dest = segue.destination  as! IndustryType
            
            dest.equipmentDelegate = self
            dest.selectedTitle = industryValue
        }
            
        else if segue.identifier == "Contact"{
            
            let dest = segue.destination as! MainContactVC
            
            dest.contactDelegate = self
            dest.segueStatus = true
            dest .segueType = self.SegueField
            
        }
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Autocomplete ERROR \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

