//
//  ContractDetailsVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 27/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

//
//  NewContractVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 30/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import HCSStarRatingView





class ContractDetailsVC: UIViewController, typeDelegate, contactdelegate,equipmentTypeDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    
    
    
    
    
    
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
    
    
    @IBOutlet weak var saveButton: UIButton!
    
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
    
    
    @IBOutlet var addPictureButton: [UIButton]!

    
    
    
    var taxImage = [UIImage]()
    
    var bankImage = [UIImage]()
    var equipmentImage = [UIImage]()
    var insuranceImage = [UIImage]()
    var signorImage = [UIImage]()
    var invoiceImage = [UIImage]()
    var closingImage = [UIImage]()
    var pageSignedImage = [UIImage]()
    var everythingImage = [UIImage]()
    var selectedImagebuttonINdex = 0
    
    var userContract : Contract?
    
    var contactName = ""
    
    
    var editStatus = false
    let viewModel = editContractViewModel()
    
    
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    
    //    @IBOutlet weak var tagView: TagListView!
    
    var tagArray = [String]()
    
    
    // ********** Implement protocol function ******************
    func typeName(name: String) {
        
        self.contractTypeTF.text = name.lowercased()
    }
    
    func contactName(userName: String, id : String, ContractNumber : Bool?) {
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
    
    
    
    
    var equipmentValue = [String]()
    var selectedContactID : String?
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        saveButton.isHidden = true
        
        contractTypeTF.text = userContract!.contractStatus
        contractNumberTF.text = userContract!.contractNumber
        contactTF.text = userContract!.contactName
        
        selectedContactID = userContract!.id
        
        
        guard let ratingValue = NumberFormatter().number(from: userContract!.rating!) else { return }


        ratingStar.value = CGFloat(ratingValue)
        equipmentTF.text = userContract!.equipmentDetails?.joined(separator: ",")
        amountTF.text = String(userContract!.equipmentCost!)
//        purchaseDateTF.text = String.getTime(timestamp: Date(timeIntervalSince1970: (userContract!.projectedPurchaseDate! as NSString).doubleValue)))
        purchaseDateTF.text = userContract!.projectedPurchaseDate
        taxSwitch.isOn = userContract!.isTaxReturnsAvailable!
        bankSwitch.isOn = userContract!.isBankStatementAvailable!
        equipmentSwitch.isOn = userContract!.isEquipmentImagesAvailable!
        insuranceSwitch.isOn = userContract!.isInsuranceAvailable!
        signorSwitch.isOn = userContract!.isSignorAvailable!
        invoiceSwitch.isOn = userContract!.isInvoiceAvailable!
        closingSwitch.isOn = userContract!.isClosingFees!
        allpageSwitch.isOn = userContract!.isAllPagesSigned!
        everythingSwitch.isOn = userContract!.isEverythingCompleted!
        missingText.text = userContract!.missingText
        
        
        let p_date = (userContract!.projectedPurchaseDate! as NSString).doubleValue
        
        
        
        
        let convertDate = NSDate(timeIntervalSince1970: p_date)
        
        print(convertDate.description)
        
        
        
        
       
        
        
        taxViewHeight.constant = 0
        bankViewHeight.constant = 0
        equipmentViewHeight.constant = 0
        
        taxCollectionView.delegate = self
        taxCollectionView.dataSource = self
        
        bankCollectionView.delegate = self
        bankCollectionView.dataSource = self
        
        equipmentCollectionVIew.delegate = self
        equipmentCollectionVIew.dataSource = self
        
        taxCollectionView.reloadData()
        bankCollectionView.reloadData()
        equipmentCollectionVIew.reloadData()
        
        
        purchaseDateTF.delegate = self
        
        
        
        
        //        tagView.delegate = self
        
        contactTF.delegate = self
        //        tagTF.delegate = self
        
        let typeButton = UITapGestureRecognizer(target: self, action: #selector(typeSegue))
        
        self.contractTypeTF.addGestureRecognizer(typeButton)
        
        let equipmentButton = UITapGestureRecognizer(target: self, action: #selector(equipmentSegue))
        
        self.equipmentTF.addGestureRecognizer(equipmentButton)
        
        let amountButton = UITapGestureRecognizer(target: self, action: #selector(amountEdit))
        
        self.amountTF.addGestureRecognizer(amountButton)
        
        
        
        let ratingButton = UITapGestureRecognizer(target: self, action: #selector(ratingEdit))
        
        self.ratingStar.addGestureRecognizer(ratingButton)
        
        
        
    }
    
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.editStatus = true
        saveButton.isHidden = false
        
        if textField == purchaseDateTF{
            
            textField.inputView = nil
            
            performSegue(withIdentifier: "DATE", sender: nil)
        }
        
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        
        
        self.saveData()
        
    }
    
    // ************* Add Picture ***********
    
    @IBAction func addPictureAction(_ sender: UIButton) {
        
        
        self.selectedImagebuttonINdex = sender.tag
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        
        
        let modeCollection = UIAlertController(title: "", message:"Choose Source to add your Image", preferredStyle: .actionSheet)
        let photoAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            imagepicker.sourceType = .photoLibrary
            self.present(imagepicker, animated: true, completion: nil)
            
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            imagepicker.sourceType = .camera
            
            self.present(imagepicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        modeCollection.addAction(photoAction)
        modeCollection.addAction(cameraAction)
        
        modeCollection.addAction(cancelAction)
        
        
        self.present(modeCollection, animated: true, completion: nil)
        
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.saveImage(Image: selectedImage)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func saveImage( Image : UIImage){
        
        switch self.selectedImagebuttonINdex {
        case 0:
            taxImage.append(Image)
            
            print(taxImage)
            print(taxImage.count)
            
            self.taxCollectionView.reloadData()
            
        case 1:
            bankImage.append(Image)
            bankCollectionView.reloadData()
        case 2:
            equipmentImage.append(Image)
            equipmentCollectionVIew.reloadData()
        case 3:
            insuranceImage.append(Image)
        case 4:
            signorImage.append(Image)
        case 5:
            invoiceImage.append(Image)
        case 6:
            closingImage.append(Image)
        case 7:
            pageSignedImage.append(Image)
        case 8:
            everythingImage.append(Image)
        default:
            return
        }
        
    }
    
    
    
    // ******************* SAVE BUTTON ACTION ***************************
    
   
    
    
    func saveData(){
        
        
        
        print("SAVE")
        
        let apiLink = appGlobalVariable.apiBaseURL + "contracts/updatecontract"


        if contractTypeTF.text?.isEmpty == false  && contactTF.text?.isEmpty == false && purchaseDateTF.text?.isEmpty == false && amountTF.text?.isEmpty == false && equipmentTF.text?.isEmpty == false && missingText.text?.isEmpty == false{

            let inputDetail : [String : Any] = ["v": 0,
                                                "id": userContract!.id!,
                                                "userId": appGlobalVariable.userID,
                                                "contractNumber": userContract!.contractNumber!,
                                                "contactId": userContract!.contactId!,
                                                "addedDate": purchaseDateTF.text!,
                                                "allPagesSignedImage": "",
                                                "allPendingDocumentCounts": 0,
                                                "bankStatements": [],
                                                "closingFees": "",
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
                                                "projectedPurchaseDate": purchaseDateTF.text!,
                                                "rating": String(Int(ratingStar.value)),
                                                "signorAndSecretaryId": "",
                                                "taxReturnImages": []
            ]


            print("-------------------------")
            print(inputDetail)
            print(apiLink)
            print(selectedContactID)
            print("-------------------------")



                        viewModel.editContract(API: apiLink, Textfields: inputDetail) { (Status, Result) in
            
                            if Status == true{
            
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
        }

        else{
            self.alertMessage(Title: "TextField Empty", Message: "Some of textfield is left empty")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == self.taxCollectionView{
            return taxImage.count
        }
            
        else if collectionView == self.bankCollectionView{
            return bankImage.count
        }
        
        else{
        return equipmentImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.taxCollectionView{
            
            let taxCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tax", for: indexPath) as! TaxCollectionViewCell
            print(indexPath.row)
            
            print("*******************")
            print(taxImage[indexPath.row])
            print("*******************")
            
            
            taxCell.docImage.image = taxImage[indexPath.row]
            
            
            return taxCell
            
        }
            
        else if collectionView == self.bankCollectionView{
            let bankCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Bank", for: indexPath) as! BankCollectionViewCell
            
            bankCell.docImage.image = bankImage[indexPath.row]
            
            
            return bankCell
        }
            
            //
            
        else {
            
            let equipmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Equipment", for: indexPath) as! EquipmentCollectionViewCell
            
            equipmentCell.docImage.image = equipmentImage[indexPath.row]
            
            
            return equipmentCell
        }
    }
    
    
    
    @objc func typeSegue(){
        
        self.editStatus = true
        saveButton.isHidden = false
        performSegue(withIdentifier: "Type", sender: nil)
    }
    
    @objc func equipmentSegue(){
        
        self.editStatus = true
        saveButton.isHidden = false
        performSegue(withIdentifier: "Equipment_Type", sender: nil)
        
        
    }
    
    
    
    @objc func amountEdit(){
        self.editStatus = true
        saveButton.isHidden = false
        
    }
    
    @objc func ratingEdit(){
        self.editStatus = true
        saveButton.isHidden = false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.editStatus = true
        saveButton.isHidden = false

        
        if textField == contactTF{
            //
            
            performSegue(withIdentifier: "Contact", sender: nil)
            
            //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //
            //            let vc = storyboard.instantiateViewController(withIdentifier: "Contact")
            //            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
    
    
    
    
    
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
    
    
    @IBAction func taxSwitchAction(_ sender: UISwitch) {
        
        self.editStatus = true
        saveButton.isHidden = false
        
        if sender.isOn == true{
            taxViewHeight.constant = 90
        }
        else{
            taxViewHeight.constant = 0
            
        }
        
    }
    
    @IBAction func bankSwitchAction(_ sender: UISwitch) {
        
        self.editStatus = true
        saveButton.isHidden = false
        
        if sender.isOn == true{
            bankViewHeight.constant = 90
        }
        else{
            bankViewHeight.constant = 0
            
        }
    }
    
    @IBAction func equipmentSwitchAction(_ sender: UISwitch) {
        
        self.editStatus = true
        saveButton.isHidden = false
        
        if sender.isOn == true{
            equipmentViewHeight.constant = 90
        }
        else{
            equipmentViewHeight.constant = 0
            
        }
    }
    
    @IBAction func insuranceSwitchAction(_ sender: Any) {
        self.editStatus = true
        saveButton.isHidden = false
    }
    
    @IBAction func signorSwitchAction(_ sender: Any) {
        self.editStatus = true
        saveButton.isHidden = false
    }
    
    @IBAction func invoiceSwitchAction(_ sender: Any) {
        self.editStatus = true
        saveButton.isHidden = false
    }
    
    @IBAction func closeFeeSwitchAction(_ sender: Any) {
        self.editStatus = true
        saveButton.isHidden = false
    }
    
    @IBAction func allPageSwitchAction(_ sender: Any) {
        self.editStatus = true
        saveButton.isHidden = false
    }
    
    @IBAction func everythingSwitchAction(_ sender: Any) {
        self.editStatus = true
        saveButton.isHidden = false
    }
    
    
    
    
    
    
    
    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        
        if editStatus == true{
            let alert = UIAlertController(title: "Some Change Found!!", message: "Some changes have seen in current contract. Do you want to SAVE", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
                self.saveData()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                self.navigationController?.popViewController(animated: true)

            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        else{
            self.navigationController?.popViewController(animated: true)

        }
        
        
    }
    
}


extension String{
    static func getTime(timestamp:Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: timestamp)
    }
}




