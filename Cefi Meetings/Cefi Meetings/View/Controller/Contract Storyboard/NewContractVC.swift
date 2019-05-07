//
//  NewContractVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 30/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import HCSStarRatingView
import Alamofire



// ******************* DECLARE PROTOCOL required by Contract ***************************
protocol typeDelegate {
    func typeName(labelName: String, serverName : String)
}

protocol contactdelegate {
    func contactName(userName : String, id : String, ContractNumber : Bool?, businessName: String)
}

protocol equipmentTypeDelegate {
    func equipmentType(list: [String])
}






class NewContractVC: UIViewController, typeDelegate, contactdelegate,equipmentTypeDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate {
    
    
    
  
 
    

    // ******************* OUTLET ***************************
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var missingTextView: Custom_View!
    
    @IBOutlet weak var activityView: Custom_View!
    @IBOutlet weak var mainVIew: UIView!
    
    
    @IBOutlet weak var taxCollectionView: UICollectionView!
    @IBOutlet weak var bankCollectionView: UICollectionView!
    @IBOutlet weak var equipmentCollectionVIew: UICollectionView!
    @IBOutlet weak var insuranceCollectionVIew: UICollectionView!
    @IBOutlet weak var signorCollectionVIew: UICollectionView!
    @IBOutlet weak var invoiceCollectionVIew: UICollectionView!
    @IBOutlet weak var closingCollectionVIew: UICollectionView!
    @IBOutlet weak var allPageCollectionVIew: UICollectionView!
    @IBOutlet weak var everyCollectionVIew: UICollectionView!






    
    
    @IBOutlet weak var contractTypeTF: UITextField!
    @IBOutlet weak var contractNumberTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var purchaseDateTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var ratingStar: HCSStarRatingView!
    @IBOutlet weak var equipmentTF: UITextField!
    @IBOutlet weak var missingText: UITextView!
    
    @IBOutlet weak var bankStateView: UIView!
    @IBOutlet weak var taxView: UIView!
    @IBOutlet weak var equipmentView: UIView!
    @IBOutlet weak var insuranceStateView: UIView!
    @IBOutlet weak var signorStateView: UIView!
    @IBOutlet weak var invoiceStateView: UIView!
    @IBOutlet weak var closingStateView: UIView!
    @IBOutlet weak var allPageStateView: UIView!
    @IBOutlet weak var everythingStateView: UIView!

    
    @IBOutlet weak var taxViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bankViewHeight: NSLayoutConstraint!
    @IBOutlet weak var insuranceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var signorViewHeight: NSLayoutConstraint!
    @IBOutlet weak var invoiceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var closingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var allPageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var everythingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var equipmentViewHeight: NSLayoutConstraint!
    
    @IBOutlet var addPictureButton: [UIButton]!
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    
    
    
    
    
    // ******************* VARIABLE ***************************
    var LeadDelegate : NewLeadDelegate!
    let datePicker = UIDatePicker()
    var contactName = ""
    var equipmentValue = [String]()
    var selectedContactID : String?
    let newContractviewModel = NewContractViewModel()
    let uploadImageViewModel = ImageUploadViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    var tagArray = [String]()
    var date = Date()
    var VisitID = ""
    
    var taxImage = [UIImage]()
    var bankImage = [UIImage]()
    var equipmentImage = [UIImage]()
    var insuranceImage = [UIImage]()
    var signorImage = [UIImage]()
    var invoiceImage = [UIImage]()
    var closingImage = [UIImage]()
    var pageSignedImage = [UIImage]()
    var everythingImage = [UIImage]()
    
    
    
    var taxImageURl = [String]()
    var bankImageURl = [String]()
    var equipmentImageURl = [String]()
    var insuranceImageURl  = [String]()
    var signorImageURl  = [String]()
    var invoiceImageURl  = [String]()
    var closingImageURl  = [String]()
    var pageSignedImageURl  = [String]()
    var everythingImageURl  = [String]()
    
    
    
    var selectedImagebuttonINdex = 0
    
    var totalImageAdded = 0
    var uploadCount = 0
    var insuranceImageCount = 0
    var signorImageCount = 0
    var invoiceImageCount = 0
    var closingImageCount = 0
    var pageSignedImageCount = 0
    var everythingImageCount = 0
    var ContactStatus = ""
    
    var businessTitle:String?
    var leadFlag = false
    
    var selectedCollection  = ""
    
    // ********** PROTOCOL FUNCTION ******************
    func typeName(labelName: String, serverName : String) {
        
        self.ContactStatus = serverName
        self.contractTypeTF.text = labelName
        
        
        print(labelName)
        print(serverName)
    }
    
    func contactName(userName: String, id : String, ContractNumber : Bool?, businessName: String) {
        contactTF.text = userName.capitalizingFirstLetter()
        businessTitle = businessName
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
        
        

        
        
        mainViewHeight.constant = 1200
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Avenir Black", size: 21)!]
        
        // Making navigation bar transparent
        naviBar.setBackgroundImage(UIImage(), for: .default)
        naviBar.shadowImage = UIImage()
        
        activityView.isHidden = true
        contactTF.text = contactName
        
        taxViewHeight.constant = 0
        bankViewHeight.constant = 0
        equipmentViewHeight.constant = 0
        insuranceViewHeight.constant = 0
        signorViewHeight.constant = 0
        invoiceViewHeight.constant = 0
        closingViewHeight.constant = 0
        allPageViewHeight.constant = 0
        everythingViewHeight.constant = 0

        
        
        
        
        
        taxCollectionView.delegate = self
        taxCollectionView.dataSource = self
        taxCollectionView.reloadData()

        
        bankCollectionView.delegate = self
        bankCollectionView.dataSource = self
        bankCollectionView.reloadData()

        
        
        equipmentCollectionVIew.delegate = self
        equipmentCollectionVIew.dataSource = self
        equipmentCollectionVIew.reloadData()
        
        
        insuranceCollectionVIew.delegate = self
        insuranceCollectionVIew.dataSource = self
        insuranceCollectionVIew.reloadData()

        
        signorCollectionVIew.delegate = self
        signorCollectionVIew.dataSource = self
        signorCollectionVIew.reloadData()
        
        
        
        invoiceCollectionVIew.delegate = self
        invoiceCollectionVIew.dataSource = self
        invoiceCollectionVIew.reloadData()
        
        
        closingCollectionVIew.delegate = self
        closingCollectionVIew.dataSource = self
        closingCollectionVIew.reloadData()
        
        allPageCollectionVIew.delegate = self
        allPageCollectionVIew.dataSource = self
        allPageCollectionVIew.reloadData()
        
        
        everyCollectionVIew.delegate = self
        everyCollectionVIew.dataSource = self
        everyCollectionVIew.reloadData()
        
        
        
        
        
        
        
        purchaseDateTF.delegate = self
        contactTF.delegate = self
        
        missingText.delegate = self
        amountTF.delegate = self
        
        let typeButton = UITapGestureRecognizer(target: self, action: #selector(typeSegue))
        self.contractTypeTF.addGestureRecognizer(typeButton)
        
        let equipmentButton = UITapGestureRecognizer(target: self, action: #selector(equipmentSegue))
        self.equipmentTF.addGestureRecognizer(equipmentButton)
        
        let contactButton = UITapGestureRecognizer(target: self, action: #selector(contactSegue))
        self.contactTF.addGestureRecognizer(contactButton)
        
        
        
        // CALL DATE FUNCTIONALITY
       self.showDatePicker()

    }
    
    
    
    
    
    
    // ****************** TEXTFIELD BEGIN EDITTING  **********************

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        missingText.textColor = UIColor(red: 0.392, green: 0.596, blue: 0.278, alpha: 1)
        missingText.text = ""
    }
    
   
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == amountTF{
            
            let amount = Int(amountTF.text!)
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencySymbol = "$" 
            let formattedNumber = numberFormatter.string(from: NSNumber(value:amount!))
            
            
            amountTF.text = String(formattedNumber!)
            
        }
        
        return true
    }
    
    
    
    
    
    
    // ******************* SHOW DATE FUNCTION ***************************

    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
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
    
    
    
    
    
    
    
    // ************* ADD IMAGE BUTTON ACTION *********************

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
    
    
    
    // ****************** IMAGE PICKER FUNCTION  **********************

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.saveImage(Image: selectedImage)
        self.dismiss(animated: true, completion: nil)

    }
    
    
    
    
    
    
    
    
    // ******************  FUNCTION THAT HANDLE RELATE SELECTED IMAGE & IT'S STORING VARIABLE **********************

    func saveImage( Image : UIImage){
        
  
        
        switch self.selectedImagebuttonINdex {
        case 0:
            taxImage.append(Image)
            self.taxCollectionView.reloadData()
            taxViewHeight.constant = 90
            mainViewHeight.constant += 100


            
        case 1:
            bankImage.append(Image)
            bankCollectionView.reloadData()
            bankViewHeight.constant = 90
            mainViewHeight.constant += 100

            
            
        case 2:
            equipmentImage.append(Image)
            equipmentCollectionVIew.reloadData()
            equipmentViewHeight.constant = 90
            mainViewHeight.constant += 100

            
            
        case 3:
            insuranceImage.append(Image)
            insuranceCollectionVIew.reloadData()
            insuranceViewHeight.constant = 90
            mainViewHeight.constant += 100
            
        case 4:
            signorImage.append(Image)
            signorCollectionVIew.reloadData()
            signorViewHeight.constant = 90
            mainViewHeight.constant += 100
            
        case 5:
            invoiceImage.append(Image)
            invoiceCollectionVIew.reloadData()
            invoiceViewHeight.constant = 90
            mainViewHeight.constant += 100
           
        case 6:
            closingImage.append(Image)
            closingCollectionVIew.reloadData()
            closingViewHeight.constant = 90
            mainViewHeight.constant += 100
           
        case 7:
            pageSignedImage.append(Image)
            allPageCollectionVIew.reloadData()
            allPageViewHeight.constant = 90
            mainViewHeight.constant += 100
           
        case 8:
            everythingImage.append(Image)
            everyCollectionVIew.reloadData()
            everythingViewHeight.constant = 90
            mainViewHeight.constant += 100
        default:
            return
        }
        
        
        
 

        
    }
    
    
    
    
    
    
    // ******************* SAVE BUTTON ACTION ***************************

    
    @IBAction func saveAction(_ sender: Any) {
        
        
        print("tax: \(taxImage.count)")
        print("bank: \(bankImage.count)")
        print("equipment: \(equipmentImage.count)")
        print("signor: \(signorImage.count)")
        print("insurance: \(insuranceImage.count)")
        print("invoice: \(invoiceImage.count)")
        print("closing: \(closingImage.count)")
        print("paginng:\(pageSignedImage.count)")
        print("everything: \(everythingImage.count)")
        
        
          if contractTypeTF.text?.isEmpty == false  && contactTF.text?.isEmpty == false && purchaseDateTF.text?.isEmpty == false && amountTF.text?.isEmpty == false && equipmentTF.text?.isEmpty == false {
        
        
        self.totalImageAdded = taxImage.count + bankImage.count + equipmentImage.count + insuranceImage.count + signorImage.count + invoiceImage.count + closingImage.count + pageSignedImage.count + everythingImage.count
        
        
        print(self.totalImageAdded)
            
        mainVIew.isUserInteractionEnabled = false
        activityView.isHidden = false
        
                                    // ------------- NO IMAGE ------------------
        if self.totalImageAdded == 0 {
            self.createDatabaseRecord()
        }
        
            
            
            
            
        
        else {
        
                                // --------------- INSURANCE IMAGE UPLOAD ---------------------
        
            if insuranceImage.isEmpty == false {
                
                
                for indexNumber in 0...(insuranceImage.count - 1){
                    
                    let image = insuranceImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.insuranceImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
            
            
        

        
        
        
        
        
        
                                            // ------------ SIGNOR IMAGE UPLOAD ---------------
            
            if signorImage.isEmpty == false {
                
                
                for indexNumber in 0...(signorImage.count - 1){
                    
                    let image = signorImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.signorImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
            
            
            

        
        
                                                //------------ INVOICE IMAGE UPLOAD ---------------------
            
            
            if invoiceImage.isEmpty == false {
                
                
                for indexNumber in 0...(invoiceImage.count - 1){
                    
                    let image = invoiceImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.invoiceImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
            
            
            

        
        
        
                                                //------------- CLOSING IMAGE UPLOAD -----------------------
            
            
            if closingImage.isEmpty == false {
                
                
                for indexNumber in 0...(closingImage.count - 1){
                    
                    let image = invoiceImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.closingImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
            
            
            

        
                                                    //------------ PAGE SIGNED IMAGE UPLOAD ------------
            
            if pageSignedImage.isEmpty == false {
                
                
                for indexNumber in 0...(pageSignedImage.count - 1){
                    
                    let image = pageSignedImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.pageSignedImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
            
            
            
            

        
            
            
    
        
                                                //------------- EVERYTING IMAGE UPLOAD -------------------
            
            
            if everythingImage.isEmpty == false {
                
                
                for indexNumber in 0...(everythingImage.count - 1){
                    
                    let image = everythingImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.everythingImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
            
            
            
            

        
        
        
        
        
                                                //--------------- TAX IMAGE UPLOAD ----------------------
            
            
            if taxImage.isEmpty == false {
                
                
                for indexNumber in 0...(taxImage.count - 1){
                    
                    let image = taxImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.taxImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
            
            

        
        
        
        
        
                                            //--------------- BANK UPLOAD ---------------------

            if bankImage.isEmpty == false {
                
                
                for indexNumber in 0...(bankImage.count - 1){
                    
                    let image = bankImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.bankImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
        
        
        
        
        
                                                        //------------ EQUIPMENT UPLOAD -------------
        
        
            if equipmentImage.isEmpty == false {
                
                
                for indexNumber in 0...(equipmentImage.count - 1){
                    
                    let image = equipmentImage[indexNumber]
                    let imgData = image.jpegData(compressionQuality: 0.5)
                    let param = ["image":image]
                    
                    
                    uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                        
                        
                        self.uploadCount += successCount!
                        print("*****************")
                        
                        //                print(imageURL)
                        self.equipmentImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.createDatabaseRecord()
                            
                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
        }
        
        }
        
                else{
                    self.alertMessage(Title: "TextField Empty", Message: "Some of textfield is left empty")
                }

        
        
        
    }
    
  

    
    
    
    
    
    // ******************  VIEWMODEL FUNCTION **********************

    func createDatabaseRecord(){
        
        
        
        let amount = amountTF.text?.removeFormatAmount()
        
//        print(amount)
//
//        print(selectedContactID)
        
        let apiLink = appGlobalVariable.apiBaseURL + "contracts/addcontract"
  
        
            let inputDetail : [String : Any] = ["v": 0,
                                                "id": "",
                                                "addedDate": "",
                                                "allPagesSignedImage": pageSignedImageURl ,
                                                "allPendingDocumentCounts": 0,
                                                "bankStatements": bankImageURl ,
                                                "closingFees": closingImageURl ,
                                                "contactId": selectedContactID!,
                                                "contractNumber": contractNumberTF.text as Any,
                                                "contractStatus": self.ContactStatus.lowercased(),
                                                "equipmentCost": String(amount!),
                                                "equipmentDetails": equipmentValue,
                                                "equipmentImages": equipmentImageURl ,
                                                "everyThingCompleted": everythingImageURl ,
                                                "insuranceCertificate": insuranceImageURl ,
                                                "invoice": invoiceImageURl ,
                                                "isAllPagesSigned": false,
                                                "isBankStatementAvailable": false,
                                                "isClosingFees": false,
                                                "isEquipmentImagesAvailable": false,
                                                "isEverythingCompleted": false,
                                                "isInsuranceAvailable": false,
                                                "isInvoiceAvailable": false,
                                                "isSignorAvailable": false,
                                                "isTaxReturnsAvailable": false,
                                                "missingText": missingText.text!,
                                                "projectedPurchaseDate": String((floor(date.timeIntervalSince1970) * 1000)),
                                                "rating": String(Int(ratingStar.value)),
                                                "signorAndSecretaryId": signorImageURl ?? "",
                                                "taxReturnImages": taxImageURl,
                                                "userId": appGlobalVariable.userID,
                                                "visitId": self.VisitID
            ]
            
//
//            print("-------------------------")
//            print(inputDetail)
//            print(apiLink)
//            print(selectedContactID)
//            print("-------------------------")
        
            
            
            newContractviewModel.newContractCreate(API: apiLink, Textfields: inputDetail) { (Status, Result) in
                
                if Status == true{
                    
                    self.navigationController?.popViewController(animated: true)
                    if self.leadFlag == true{
                    self.LeadDelegate.leadDetail(contactName: self.contactTF.text!, businessName: self.businessTitle!, ContractNumber: Result!, Rating: self.ratingStar.value)
                    self.leadFlag = false
                    }
                    self.activityView.isHidden = true

                }
                else {
                    self.alertMessage(Title: "Server Error", Message: Result!)
                }
            }

        
        
        
    }
    
    
    
    
    
    
    
    
    // ******************* COLLECTIONVIEW DELEGATE PROTOCOL FUNCTION ***************************

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        
        if collectionView == self.taxCollectionView{
            return taxImage.count
        }
        
        else if collectionView == self.bankCollectionView{
            return bankImage.count
        }
            
        else if collectionView == self.equipmentCollectionVIew{
            return equipmentImage.count
        }
        else if collectionView == self.insuranceCollectionVIew{
            return insuranceImage.count
        }
        else if collectionView == self.signorCollectionVIew{
            return signorImage.count
        }
        else if collectionView == self.invoiceCollectionVIew{
            return invoiceImage.count
        }
        else if collectionView == self.closingCollectionVIew{
            return closingImage.count
        }
            
        else if collectionView == self.allPageCollectionVIew{
            return pageSignedImage.count
        }
            
            
        else {
        return everythingImage.count
        }
        
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        // ************ TAX *****************

        
        if collectionView == self.taxCollectionView{
            
            let taxCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tax", for: indexPath) as! TaxCollectionViewCell

            
            taxCell.docImage.image = taxImage[indexPath.row]
            
            taxCell.cancelButton.tag = indexPath.row
            
            self.selectedCollection = "Tax"
            
            taxCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
            
            return taxCell

        }
            
            
            // ************ BANK *****************
        else if collectionView == self.bankCollectionView{
             let bankCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Bank", for: indexPath) as! BankCollectionViewCell
            
            bankCell.docImage.image = bankImage[indexPath.row]
            
            bankCell.cancelButton.tag = indexPath.row + 100
            self.selectedCollection = "Bank"
            
            bankCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
            
            return bankCell
        }
        
//
            // ************ EQUIPMENT *****************

        else if collectionView == self.equipmentCollectionVIew{

        let equipmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Equipment", for: indexPath) as! EquipmentCollectionViewCell

            equipmentCell.docImage.image = equipmentImage[indexPath.row]
        
            equipmentCell.cancelButton.tag = indexPath.row + 200
            self.selectedCollection = "Equipment"
            
            equipmentCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
        return equipmentCell
        }
        
            // ************ INSURANCE *****************
            
        else if collectionView == self.insuranceCollectionVIew{
            
            let insuranceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Insurance", for: indexPath) as! InsuranceCollectionViewCell
            
            insuranceCell.docImage.image = insuranceImage[indexPath.row]
            
            insuranceCell.cancelButton.tag = indexPath.row + 300
            self.selectedCollection = "Insurance"
            
            insuranceCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
            return insuranceCell
        }

            // ************ SIGNOR *****************
            
        else if collectionView == self.signorCollectionVIew{
            
            let signorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Signor", for: indexPath) as! SignorCollectionViewCell
            
            signorCell.docImage.image = signorImage[indexPath.row]
            
            signorCell.cancelButton.tag = indexPath.row + 400
            self.selectedCollection = "Signor"
            
            signorCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
            return signorCell
        }
            
            // ************ INVOICE *****************
            
        else if collectionView == self.invoiceCollectionVIew{
            
            let invoiceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Invoice", for: indexPath) as! InvoiceCollectionViewCell
            
            invoiceCell.docImage.image = invoiceImage[indexPath.row]
            
            invoiceCell.cancelButton.tag = indexPath.row + 500
            self.selectedCollection = "Invoice"
            
            invoiceCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
            return invoiceCell
        }
            
            
            // ************ CLOSING *****************
            
        else if collectionView == self.closingCollectionVIew{
            
            let closingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Closing", for: indexPath) as! ClosingCollectionViewCell
            
            closingCell.docImage.image = closingImage[indexPath.row]
            
            closingCell.cancelButton.tag = indexPath.row + 600
            self.selectedCollection = "Closing"
            
            closingCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
            return closingCell
        }
            
            // ************ ALL PAGING *****************
            
        else if collectionView == self.allPageCollectionVIew{
            
            let pagingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllPage", for: indexPath) as! AllPageCollectionViewCell
            
            pagingCell.docImage.image = pageSignedImage[indexPath.row]
            
            pagingCell.cancelButton.tag = indexPath.row + 700
            self.selectedCollection = "AllPaging"
            
            pagingCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
            return pagingCell
        }
            
            
            
            
            // ************ EVERYTHING *****************
            
        else {
            
            let everythingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EveryThing", for: indexPath) as! EverythingCollectionViewCell
            
            everythingCell.docImage.image = everythingImage[indexPath.row]
            
            everythingCell.cancelButton.tag = indexPath.row + 800
            self.selectedCollection = "EveryThing"
            
            everythingCell.cancelButton.addTarget(self, action: #selector(removePicture), for: .touchUpInside)
            return everythingCell
        }

    }
    

    

    
    
    
    
    @objc func removePicture(button : UIButton){
        let indexNumber = button.tag
        
        print(indexNumber)
     
        
        
        let alertVC = UIAlertController(title: "CONFIRMATION", message: "Are you sure you wish to delete this image?", preferredStyle: .actionSheet)
        let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let Confirm = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            if indexNumber < 100{
                
                self.taxImage.remove(at: indexNumber)
                self.taxCollectionView.reloadData()
                
            }
                
            else if (indexNumber >= 100) && (indexNumber < 200){
                
                self.bankImage.remove(at: indexNumber - 100)
                self.bankCollectionView.reloadData()
                
            }
            
            else if (indexNumber >= 200) && (indexNumber < 300){
                
                self.equipmentImage.remove(at: indexNumber - 200)
                self.equipmentCollectionVIew.reloadData()
                
            }
            else if (indexNumber >= 300) && (indexNumber < 400){
                
                self.insuranceImage.remove(at: indexNumber - 300)
                self.insuranceCollectionVIew.reloadData()
                
            }
            else if (indexNumber >= 400) && (indexNumber < 500){
                
                self.signorImage.remove(at: indexNumber - 400)
                self.signorCollectionVIew.reloadData()
                
            }
            else if (indexNumber >= 500) && (indexNumber < 600){
                
                self.invoiceImage.remove(at: indexNumber - 500)
                self.invoiceCollectionVIew.reloadData()
                
            }
            else if (indexNumber >= 600) && (indexNumber < 700){
                
                self.closingImage.remove(at: indexNumber - 600)
                self.closingCollectionVIew.reloadData()
                
            }
            else if (indexNumber >= 700) && (indexNumber < 800){
                
                self.pageSignedImage.remove(at: indexNumber - 700)
                self.allPageCollectionVIew.reloadData()
                
            }
                
                
            else if (indexNumber >= 800){
                
                self.everythingImage.remove(at: indexNumber - 800)
                self.everyCollectionVIew.reloadData()
                
            }
            
        }
        
        alertVC.addAction(dismiss)
        alertVC.addAction(Confirm)
        
        self.present(alertVC, animated: true, completion: nil)
       
        
        
        
    }
    
    
    
    
    
    // ******************  CUSTOM SEGUE **********************

    @objc func typeSegue(){
        performSegue(withIdentifier: "Type", sender: nil)
    }
    
    @objc func equipmentSegue(){
        performSegue(withIdentifier: "Equipment_Type", sender: nil)

        
    }
    
    
    @objc func contactSegue(){
        performSegue(withIdentifier: "Contact", sender: nil)

        
    }
    
    // ****************** TEXT FIELD BEGIN EDIT  **********************

    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        if textField == contactTF{
//
//
//            performSegue(withIdentifier: "Contact", sender: nil)
//
//
//        }
        
        if textField == amountTF{
//            amountTF.text = "$ "
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
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
   
    
    
    
    
    

    // ******************* ALERT VIEWCONTROLLER ***************************

    
    func alertMessage(Title : String, Message : String ){
        
        let alertVC = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertVC.addAction(dismissButton)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    
    
    
    // ******************  CANCEL BUTTON ACTION **********************

    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}



