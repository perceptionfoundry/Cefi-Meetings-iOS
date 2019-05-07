//
//  UserDetailVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class UserDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, contactChange {
    
    
    
    
    
    // ****************** PROTOCOL FUNCTION *****************

    func editContact(value: Contact) {
        
//        print(value)
        
        self.userDetail = value
        
        fieldUpdate()
    }
    
    
    
    
    
    
    // ****************** OUTLET *****************

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var typeCategory: UILabel!
    @IBOutlet weak var industryCatergory: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var contractTable: UITableView!
    @IBOutlet weak var unemptyTableImage: UIImageView!
    @IBOutlet weak var addContractButton: UIButton!
    
    @IBOutlet weak var contractLabel: UILabel!
    
    @IBOutlet weak var referredLabe: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    
    
    // ****************** VARIABLE *****************

    
    var appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    var viewModel = ContactContractDetailViewModel()
    var userDetail : Contact?
    var tableContent = [Contract]()
    var justTest = true
    
    var placeName: String?
    
    var getContractViewModel = GetSpecificContractViewModel()
    
    
    
    // ****************** VIEW DID LOAD *****************

    
    override func viewDidLoad() {
        super.viewDidLoad()

        contractTable.delegate = self
        contractTable.dataSource = self

        
        contractTable.isHidden = true

        
        
        fieldUpdate()

        
        

        
        

    }
    
    
    
 // *************** VIEW DID APPEAR  *********************
    
    override func viewDidAppear(_ animated: Bool) {
//        tableContent.removeAll()
//        fetchContent()
    }
    
    
    

    // ********************** VIEW WILL APPEAR  ************************
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        contractTable.isUserInteractionEnabled = true
        self.tabBarController?.tabBar.isHidden = true
        tableContent.removeAll()
        fetchContent()
    }
    
    
    
    
    
    
    // ******************  TEXT FIELD UPDATE FUNCTION **********************
    func fieldUpdate(){
        
//        print(userDetail)
        
        userName.text = userDetail!.contactName
        businessName.text = userDetail!.businessName
        typeCategory.text = userDetail?.contactType
        
        if typeCategory.text == "Dealer"{
            addContractButton.isHidden = true
            unemptyTableImage.isHidden = true
            contractLabel.isHidden = true
        }
        
        else{
            addContractButton.isHidden = false
            unemptyTableImage.isHidden = false
            contractLabel.isHidden = false

        }
        
        
        if userDetail!.industryType!.count > 1{
            
            let text = "\(userDetail!.industryType![0]), \(userDetail!.industryType!.count - 1) more"
            industryCatergory.text = text
        }
        else if userDetail!.industryType!.count == 1{
            industryCatergory.text = userDetail!.industryType![0]
        }
        
        
//        industryCatergory.text = userDetail!.industryType
        referredLabe.text = userDetail!.referredBy
        
        getAddressFromLatLon(pdblLatitude: userDetail!.lat!, withLongitude: userDetail!.longField!) { (place) in
            self.locationLabel.text = place!


        }
        let phone = userDetail!.phoneNumber!
        phoneNumber.text = String(phone)
        emailAddress.text = userDetail!.email
    }
    
    
    
    
    
    
    
    // ****************** VIEWMODEL FUNCTION  **********************

    func fetchContent(){
        let apiLink = appGlobalVariable.apiBaseURL+"contracts/getcontactcontracts"
        
        let dict : [String : String] = [
            "userId":appGlobalVariable.userID,
            "contactId": userDetail!.id!
            
        ]
        viewModel.fetchContractDetail(API: apiLink, TextFields: dict) { (status, message, result, count) in
            
          
//            print(count)
            
            self.tableContent = result
            
            if result.count != 0{
                self.contractTable.isHidden = false
                self.unemptyTableImage.isHidden = true

            }
            
            self.contractTable.reloadData()

        }
        
        
    }
    
    
    
    
    // ****************** TABLEVIEW PROTOCOL  **********************

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return tableContent.count
      
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contract", for: indexPath) as! UserDetailContract_TableView
        
        cell.selectionStyle = .none
        
        cell.alertView.isHidden = true

        
        if tableContent[indexPath.row].contractStatus == "closed"{
             cell.statuslabel.text = "Booked"
        }
        else{
            cell.statuslabel.text = tableContent[indexPath.row].contractStatus?.capitalizingFirstLetter()

        }
        cell.numberLabel.text = tableContent[indexPath.row].contractNumber
        
        if tableContent[indexPath.row].allPendingDocumentCounts! > 0 && tableContent[indexPath.row].contractStatus == "closed"{
            cell.alertView.isHidden = false
            cell.pendingQuantity.text = String(tableContent[indexPath.row].allPendingDocumentCounts!)
        }
        
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        contractTable.isUserInteractionEnabled = false

        contractDetail(Index: indexPath.row)
    }
    
    
    
    func contractDetail(Index : Int){
        
        
        let apiLink = appGlobalVariable.apiBaseURL+"contracts/getspecificcontract"
        
        let paramDict : [String : String    ] = [
            "userId": appGlobalVariable.userID,
            "contractId":(tableContent[Index].id)!
            
        ]
        
        getContractViewModel.fetchSpecificContractDetail(API: apiLink, TextFields: paramDict) { (Status, err, result) in
            
            
            if Status == true{
                let value =  result
                print(value)
                
                self.performSegue(withIdentifier: "Contract_Detail", sender: value)
                
                
            }
        }
    }
    
    
  
    
    
    
    // ****************** BACK BUTTON ACTION  **********************

    
    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    // ****************** EDIT BUTTON ACTION  **********************

    
    @IBAction func editAction(_ sender: Any) {
        performSegue(withIdentifier: "Edit_Segue", sender: nil)
    }
    
    
    
    
    
    // ****************** ADD BUTTON ACTION  **********************

    
    
    @IBAction func addContractAction(_ sender: Any) {
        
        
        performSegue(withIdentifier: "Contract_Segue", sender: nil)
        

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

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Edit_Segue"{
            let dest = segue.destination  as! EditContactVC
            dest.contactDetail = userDetail!
            dest.editDelegate = self
        }
        else if segue.identifier == "Contract_Segue"{
        let dest = segue.destination as! NewContractVC
        
        dest.contactName = userDetail!.contactName!
        dest.selectedContactID = userDetail!.id!
        }
        else if segue.identifier == "Contract_Detail"{
            let dest = segue.destination  as! ContractDetailsVC
            
            dest.userContract = sender as! Contract
        }
        
//
    }
    
}
