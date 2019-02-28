//
//  NewContractVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 30/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import HCSStarRatingView



// ******************* Declare Protocol required by Contract ***************************
protocol typeDelegate {
    func typeName(name : String)
}

protocol contactdelegate {
    func contactName(userName : String, id : String)
}

protocol equipmentTypeDelegate {
    func equipmentType(list: [String])
}






class NewContractVC: UIViewController, typeDelegate, contactdelegate,equipmentTypeDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    
    
  
 
    

    // ******************* OUTLET ***************************

    
    @IBOutlet weak var taxCollectionView: UICollectionView!
    @IBOutlet weak var bankCollectionView: UICollectionView!
    @IBOutlet weak var equipmentCollectionVIew: UICollectionView!
    @IBOutlet weak var contractTypeTF: UITextField!
    @IBOutlet weak var contractNumberTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var purchaseDateTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var ratingStar: HCSStarRatingView!
    @IBOutlet weak var equipmentTF: UITextField!
    @IBOutlet weak var missingText: UITextView!
    @IBOutlet weak var taxView: UIView!
    @IBOutlet weak var taxViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bankStateView: UIView!
    @IBOutlet weak var bankViewHeight: NSLayoutConstraint!
    @IBOutlet weak var equipmentView: UIView!
    @IBOutlet weak var equipmentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var taxSwitch: UISwitch!
    @IBOutlet weak var bankSwitch: UISwitch!
    @IBOutlet weak var equipmentSwitch: UISwitch!
    @IBOutlet weak var insuranceSwitch: UISwitch!
    @IBOutlet weak var signorSwitch: UISwitch!
    @IBOutlet weak var invoiceSwitch: UISwitch!
    @IBOutlet weak var closingSwitch: UISwitch!
    @IBOutlet weak var allpageSwitch: UISwitch!
    @IBOutlet weak var everythingSwitch: UISwitch!
    
    
    
    
    
    
    
    
    // ******************* VARIABLE ***************************

    let datePicker = UIDatePicker()
    var contactName = ""
    var equipmentValue = [String]()
    var selectedContactID : String?
    let viewModel = NewContractViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var tagArray = [String]()
    
    var date = Date()
    
    
    
    
    // ********** Implement protocol function ******************
    func typeName(name: String) {
        
        self.contractTypeTF.text = name.lowercased()
    }
    
    func contactName(userName: String, id : String) {
        contactTF.text = userName
        self.selectedContactID = id
    }
    
    func equipmentType(list: [String]) {
       self.equipmentValue = list
        
        if list.count > 1{
            
            let text = "\(list[0]), \(list.count - 1) more"
            equipmentTF.text = text
        }
        else if list.count == 1{
        equipmentTF.text = list[0]
        }
        
    }
    
    
   
    
    
    
    // ******************* VIEWDIDLOAD ***************************


    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactTF.text = contactName
        
        taxViewHeight.constant = 0
        bankViewHeight.constant = 0
        equipmentViewHeight.constant = 0

        taxCollectionView.delegate = self
        taxCollectionView.dataSource = self
        taxCollectionView.reloadData()

        
        bankCollectionView.delegate = self
        bankCollectionView.dataSource = self
        bankCollectionView.reloadData()

        
        
        equipmentCollectionVIew.delegate = self
        equipmentCollectionVIew.dataSource = self
        equipmentCollectionVIew.reloadData()

        
        purchaseDateTF.delegate = self
        contactTF.delegate = self
        
        
        
        
        let typeButton = UITapGestureRecognizer(target: self, action: #selector(typeSegue))
        self.contractTypeTF.addGestureRecognizer(typeButton)
        
        let equipmentButton = UITapGestureRecognizer(target: self, action: #selector(equipmentSegue))
        self.equipmentTF.addGestureRecognizer(equipmentButton)
        
        
        
        // CALL DATE FUNCTIONALITY
       self.showDatePicker()

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
        
        purchaseDateTF.inputAccessoryView = toolbar
        purchaseDateTF.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date = datePicker.date
        purchaseDateTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    
    
    // ******************* VIEWWILLAPPEAR ***************************

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    
    
    // ******************* SAVE BUTTON ACTION ***************************

    
    
    @IBAction func saveAction(_ sender: Any) {
        
        let apiLink = appGlobalVariable.apiBaseURL + "contracts/addcontract"
//        let apiLink = "http://192.168.1.61:5000/api/contracts/addcontract"


        
        if contractTypeTF.text?.isEmpty == false  && contactTF.text?.isEmpty == false && purchaseDateTF.text?.isEmpty == false && amountTF.text?.isEmpty == false && equipmentTF.text?.isEmpty == false && missingText.text?.isEmpty == false{
        
        let inputDetail : [String : Any] = ["v": 0,
                           "id": "",
                           "addedDate": "",
                           "allPagesSignedImage": "",
                           "allPendingDocumentCounts": 0,
                           "bankStatements": [],
                           "closingFees": "",
                           "contactId": selectedContactID!,
                           "contractNumber": "",
                           "contractStatus": contractTypeTF.text!,
                           "equipmentCost": amountTF.text!,
                           "equipmentDetails": equipmentValue,
                           "equipmentImages": [],
                           "everyThingCompleted": "",
                           "insuranceCertificate": "",
                           "invoice": "",
                           "isAllPagesSigned": allpageSwitch.isOn,
                           "isBankStatementAvailable": bankSwitch.isOn,
                           "isClosingFees": closingSwitch.isOn,
                           "isEquipmentImagesAvailable": equipmentSwitch.isOn,
                           "isEverythingCompleted": everythingSwitch.isOn,
                           "isInsuranceAvailable": insuranceSwitch.isOn,
                           "isInvoiceAvailable": invoiceSwitch.isOn,
                           "isSignorAvailable": signorSwitch.isOn,
                           "isTaxReturnsAvailable": taxSwitch.isOn,
                           "missingText": missingText.text!,
                           "projectedPurchaseDate": String(date.timeIntervalSince1970),
                           "rating": String(Int(ratingStar.value)),
                           "signorAndSecretaryId": "",
                           "taxReturnImages": [],
                           "userId": appGlobalVariable.userID
                        ]
        
        
        print("-------------------------")
        print(inputDetail)
        print(apiLink)
        print(selectedContactID)
        print("-------------------------")

        
    
        viewModel.newContractCreate(API: apiLink, Textfields: inputDetail) { (Status, Result) in
            
            if Status == true{
                
                self.navigationController?.popViewController(animated: true)
            }
            else {
                self.alertMessage(Title: "Server Error", Message: Result!)
            }
        }
    }
        
        else{
            self.alertMessage(Title: "TextField Empty", Message: "Some of textfield is left empty")
        }
        
        
        
    }
    
    
    
    // ******************* COLLECTIONVIEW DELEGATE PROTOCOL FUNCTION ***************************

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        
        if collectionView == self.taxCollectionView{
            return 1
        }
        
        else if collectionView == self.bankCollectionView{
            return 3
        }
        
        return 4
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.taxCollectionView{
            
            let taxCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tax", for: indexPath) as! TaxCollectionViewCell
            
            return taxCell

        }
        
        else if collectionView == self.bankCollectionView{
             let bankCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Bank", for: indexPath) as! BankCollectionViewCell
            
            return bankCell
        }
        
//
        let equipmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Equipment", for: indexPath) as! EquipmentCollectionViewCell

        
        return equipmentCell
    }
    
    
    
    
    
    
    @objc func typeSegue(){
        performSegue(withIdentifier: "Type", sender: nil)
    }
    
    @objc func equipmentSegue(){
        performSegue(withIdentifier: "Equipment_Type", sender: nil)

        
    }
    
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == contactTF{

            
            performSegue(withIdentifier: "Contact", sender: nil)
            

        }
        
       
    }
    
  

    
   
   
    // ******************* PREPARE SEUGUE FUNCTION ***************************

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "Type"{
            let dest = segue.destination as! ContractTypeVC
            
            dest.typeDelegate = self
            dest.previousSelected = contractTypeTF.text
        }
        else if segue.identifier == "Contact"{
            
            let dest = segue.destination as! MainContactVC
            
            dest.contactDelegate = self
            dest.segueStatus = true
        }
        
        else if segue.identifier == "Equipment_Type"{
            let dest = segue.destination  as! EquipmentTypeVC
            
            dest.equipmentDelegate = self
            dest.selectedTitle = equipmentValue
        }
        
        
       
    }
    
    
    
    
    
    // ******************* SWITCH BUTTON ACTION ***************************

    @IBAction func taxSwitchAction(_ sender: UISwitch) {
        
        if sender.isOn == true{
        taxViewHeight.constant = 90
        }
        else{
            taxViewHeight.constant = 0

        }
        
    }
    
    @IBAction func bankSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true{
            bankViewHeight.constant = 90
        }
        else{
            bankViewHeight.constant = 0
            
        }
    }
    
    @IBAction func equipmentSwitchAction(_ sender: UISwitch) {
        if sender.isOn == true{
            equipmentViewHeight.constant = 90
        }
        else{
            equipmentViewHeight.constant = 0
            
        }
    }
    
    @IBAction func insuranceSwitchAction(_ sender: Any) {
    }
    
    @IBAction func signorSwitchAction(_ sender: Any) {
      
    }
    
    @IBAction func invoiceSwitchAction(_ sender: Any) {
   
    }
    
    @IBAction func closeFeeSwitchAction(_ sender: Any) {
      
    }
    
    @IBAction func allPageSwitchAction(_ sender: Any) {
       
    }
    
    @IBAction func everythingSwitchAction(_ sender: Any) {
      
    }
    

    // ******************* ALERT VIEWCONTROLLER ***************************

    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}



