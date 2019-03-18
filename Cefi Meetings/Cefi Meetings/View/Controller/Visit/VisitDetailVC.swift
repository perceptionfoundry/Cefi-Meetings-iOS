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
    @IBOutlet weak var contactTF: UILabel!
    @IBOutlet weak var contractTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    @IBOutlet weak var reminderTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    
    @IBOutlet weak var editButton: Custom_Button!
    

    var meetingDetail : Meeting?
    
    
    // ******** Map related Variable *********
    var chosenPlace : meetup?
    let currentLocationMarker = GMSMarker()
    let locationManager = CLLocationManager()
    var mapCameraView: GMSMapView?
    

    
    
    var editOn = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
     
        
//        print(meetingDetail!)
        
        let dateString = meetingDetail!.addedDate!.split(separator: "T")
        
        let timeStampSplit = meetingDetail!.time!.split(separator: "T")
        let timeSplit  = timeStampSplit[1].split(separator: ":")
        let timeString = "\(timeSplit[0]):\(timeSplit[1]) "
        
        let reminderStampSplit = meetingDetail!.reminder?.split(separator: "T")
        
        let formatter = DateFormatter()
        
        var reminderTimestamp = formatter.date(from: String(timeStampSplit[1]))
        var meetingTimeStamp = formatter.date(from: String(dateString[1]))
        
        

//        print(dateString)
//        print(timeStampSplit)
//        print(reminderStampSplit)
//        print(reminderTimestamp)
//        print(meetingTimeStamp)
//
       
        contactTF.text = meetingDetail!.contactName!
        contractTF.text = meetingDetail!.contractId
        dateTF.text = String(dateString[0])
        timeTF.text = timeString
        reminderTF.text = meetingDetail!.reminder!
        
        
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

