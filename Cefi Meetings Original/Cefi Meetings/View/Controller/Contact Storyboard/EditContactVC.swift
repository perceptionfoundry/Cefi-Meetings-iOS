//
//  EditContactVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces



protocol contactChange {
    func editContact (value : Contact)
}


class EditContactVC: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate, typeDelegate, equipmentTypeDelegate,contactdelegate{
    func typeName(labelName: String, serverName: String) {
        typeTF.text = serverName

    }
    
    
    
    func contactName(userName: String, id: String, ContractNumber: Bool?, businessName: String) {
        referredTF.text = userName
        referredID = id
        
        
    }
    
    
    // ******************  PROTOCOL FUNCTION **********************

    
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
    
    
    
    func typeName(name: String) {
        typeTF.text = name
    }
    
    
    
    
    
    // ****************** MAP STRUCTURE   **********************

    
    
    struct meetup {
        var name : String
        var lat : Double = 0
        var long : Double = 0
    }
    
    // ****************** OUTLET  **********************

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
    
    
    
    
    
    // ******************  VARIABLE **********************
    
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var apiLink = ""
    let viewModel = EditContactViewModel()
    
    var contactDetail : Contact!
    var industryValue = [String]()
    var referrred = "none"
    var editDelegate : contactChange?
    var referrredName = ""
    var referredID : String?
    // ******** Map related Variable *********
    var chosenPlace : meetup?
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    var mapCameraView: GMSMapView?
    
    
    // ****************** VIEW DID LOAD  **********************

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Making navigation bar transparent
        naviBar.setBackgroundImage(UIImage(), for: .default)
        naviBar.shadowImage = UIImage()
        
        
        typeTF.text = contactDetail.contactType
        businessTF.text = contactDetail.businessName
        contactTF.text = contactDetail.contactName
        phoneTF.text = String(contactDetail.phoneNumber!)
        emailTF.text = contactDetail.email
        industryTF.text = contactDetail.industryType
        referredTF.text = contactDetail.referredBy ?? "none"
        
        let lat = (contactDetail.lat! as NSString).doubleValue
        let long  = (contactDetail.longField! as NSString).doubleValue
        
        
        
        
    
        
        self.getAddressFromLatLon(pdblLatitude: contactDetail.lat!, withLongitude: contactDetail.longField!) { (place) in
            
            self.locationTF.text = place!
            self.chosenPlace?.name = place!
            self.chosenPlace = meetup(name: place!, lat: lat, long: long)
            
            
        }
    
        
        self.apiLink = "\(appGlobalVariable.apiBaseURL)contacts/updateusercontact"
        
        
        
//        mapView.isHidden = true
        locationTF.delegate = self
        typeTF.delegate = self
        referredTF.delegate = self
        industryTF.delegate = self
        
        
        
        // Initialize device Current location delegate & respective functions
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 12)
        
        mapCameraView = GMSMapView.map(withFrame: self.mapView.bounds, camera: camera)
        
        self.mapCameraView!.animate(to: camera)
//
        let marker = GMSMarker(position: CLLocationCoordinate2DMake(lat, long))

        marker.title = contactDetail.contactName
        marker.map = self.mapCameraView
        
        
      
        
        
        self.mapView.addSubview(self.mapCameraView!)
        
        
        
        
        let typeTFTap = UITapGestureRecognizer(target: self, action: #selector(selectType))
        
        typeTF.addGestureRecognizer(typeTFTap)
        
        let industryTFTap = UITapGestureRecognizer(target: self, action: #selector(industriesType))
        
        industryTF.addGestureRecognizer(industryTFTap)
        
        
    }
    
    
    
    
    
    // ******************  CUSTOM SEGUE **********************

    @objc func selectType(){
        performSegue(withIdentifier: "Contact_Type", sender: nil)
    }
    
    @objc func industriesType(){
        performSegue(withIdentifier: "Industry_Type", sender: nil)
        
        
    }
    
    
    
    
    
    
    // ****************** VIEW WILL APPEAR  **********************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        
        
        if textField == locationTF {
            let autoCompleteController = GMSAutocompleteViewController()
            autoCompleteController.delegate = self
            
            let filter = GMSAutocompleteFilter()
            autoCompleteController.autocompleteFilter = filter
            
            self.locationManager.startUpdatingLocation()
            self.present(autoCompleteController, animated: true, completion: nil)
        }
            
        else if textField == referredTF{
            performSegue(withIdentifier: "Contact", sender: nil)

            
        }
        
    }
    
    
    
    
    // ****************** SAVE BUTTON ACTION  **********************

    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        
        
        // ********* parameter that are required by API ************
        let newContactParameter = ["userId" : appGlobalVariable.userID,
                                   "businessName" : businessTF.text!,
                                   "contactName" : contactTF.text!,
                                   "phoneNumber" : phoneTF.text!,
                                   "email" : emailTF.text!,
                                   "industryType" : industryTF.text!,
                                   "contactType" : typeTF.text!,
                                   "lat" : self.chosenPlace!.lat,
                                   "long" : chosenPlace!.long,
                                   "referredBy" : referredTF.text ?? "none",
                                   "contactId" : contactDetail.id] as [String : Any]
        
        
        
        
        
        
        print(newContactParameter)
        
        //  *************** Verifying both textfield is not left empty ***********
        if businessTF.text?.isEmpty == false && contactTF.text?.isEmpty == false && phoneTF.text?.isEmpty == false && emailTF.text?.isEmpty == false && industryTF.text?.isEmpty == false && contactTF.text?.isEmpty == false && locationTF.text?.isEmpty == false{
            
            
            
            
            // ****** Hitting ApiLink with required parameter **********
            
            viewModel.editContact(API: self.apiLink, Textfields: newContactParameter) { (status, err, result) in
                
            
                
                if status == false{
                    
                    self.alertMessage(Title: "Edit Error", Message: err!)
                }
                    
                    
                    
                else{
                    
//                    print("**************")
//
//
//                    print(result)
//
//
//                    print("**************")
                    
                    self.editDelegate!.editContact(value: result!)
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            }
            
        }
            
        else{
            self.alertMessage(Title: "TextField Empty", Message: "Some of textfield is left empty")
        }
        
    }
    
    
    
    // ************ FETCHING PLACE VALUE *********************
    
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
//                    print("reverse geodcode fail: \(error!.localizedDescription)")
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
    
    
    
    // ******* ALERT VIEWCONTROLLER ************
    
    
    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    // ****************** CONTRACT DETAIL BUTTON ACTION  **********************

    
    @IBAction func contractDetailAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contract_Detail")
        //        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    // ******************  CANCEL BUTTON ACTION **********************

    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension EditContactVC: GMSAutocompleteViewControllerDelegate {
    
    //  ************* GOOGLE AUTOCOMPLETE DELEGATE FUNCTIONS *********************
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
            
        }
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Autocomplete ERROR \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
