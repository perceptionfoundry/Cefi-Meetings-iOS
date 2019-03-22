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
    
    
    
    
    
    
    
    
    // ***************** OUTLET **********************
    
    
    @IBOutlet weak var activityView: Custom_View!
    @IBOutlet weak var mainVIew: UIView!
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

    
    
    // ***************** VARIABLE **********************


    
    
    
    let datePicker = UIDatePicker()
    var contactName = "JI"
    var equipmentValue = [String]()
    var selectedContactID : String?
    let newContractviewModel = NewContractViewModel()
    let uploadImageViewModel = ImageUploadViewModel()
    let appGlobalVariable = UIApplication.shared.delegate as! AppDelegate
    let viewModel = editContractViewModel()
    var userContract : Contract?
    var tagArray = [String]()
    var editStatus = false
    var date = Date()
    var taxImage = [UIImage]()
    var bankImage = [UIImage]()
    var equipmentImage = [UIImage]()
    var insuranceImage : UIImage?
    var signorImage : UIImage?
    var invoiceImage : UIImage?
    var closingImage : UIImage?
    var pageSignedImage : UIImage?
    var everythingImage : UIImage?
    var taxImageURl = [String]()
    var bankImageURl = [String]()
    var equipmentImageURl = [String]()
    var insuranceImageURl :String?
    var signorImageURl : String?
    var invoiceImageURl : String?
    var closingImageURl : String?
    var pageSignedImageURl : String?
    var everythingImageURl : String?
    var selectedImagebuttonINdex = 0
    var totalImageAdded = 0
    var uploadCount = 0
    var insuranceImageCount = 0
    var signorImageCount = 0
    var invoiceImageCount = 0
    var closingImageCount = 0
    var pageSignedImageCount = 0
    var everythingImageCount = 0
    
    
    // ********** PROTOCOL FUNCTION ******************
    func typeName(name: String) {
        
        self.contractTypeTF.text = name.lowercased()
    }
    
   func contactName(userName: String, id: String, ContractNumber: Bool?, businessName: String) {
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
    
    

    // ***************** VIEW DID LOAD  **********************

    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.isHidden = true
        
        contactTF.isUserInteractionEnabled = false
        contractNumberTF.isUserInteractionEnabled = false
        ratingStar.isUserInteractionEnabled = false
        
//        print(userContract!)
//        print(selectedContactID!)
        
        saveButton.isHidden = true
        
        contractTypeTF.text = userContract!.contractStatus ?? ""
        contractNumberTF.text = userContract!.contractNumber
        contactTF.text = userContract!.contactName
        
        selectedContactID = userContract!.id
        
        taxSwitch.setOn(userContract!.isTaxReturnsAvailable!, animated: true)
        bankSwitch.setOn(userContract!.isBankStatementAvailable!, animated: true)
        equipmentSwitch.setOn(userContract!.isEquipmentImagesAvailable!, animated: true)
       insuranceSwitch.setOn(userContract!.isInsuranceAvailable!, animated: true)
         signorSwitch.setOn(userContract!.isSignorAvailable!, animated: true)
      invoiceSwitch.setOn(userContract!.isInvoiceAvailable!, animated: true)
       closingSwitch.setOn(userContract!.isClosingFees!, animated: true)
    allpageSwitch.setOn(userContract!.isAllPagesSigned!, animated: true)
         everythingSwitch.setOn(userContract!.isEverythingCompleted!, animated: true)
        
        guard let ratingValue = NumberFormatter().number(from: userContract!.rating!) else { return }


        
        ratingStar.value = CGFloat(truncating: ratingValue)
        equipmentTF.text = userContract!.equipmentDetails?.joined(separator: ",")
        amountTF.text = String(userContract!.equipmentCost!)
        
//
        
        let dateIniOSFormat:Double = Double(userContract!.projectedPurchaseDate!) / 1000.0
        let dateInString = "\(dateIniOSFormat).000"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(dateInString)
        
        
        
        let dateFloat = Date(timeIntervalSince1970: dateIniOSFormat)
        print(dateFloat)
        let dateValue = formatter.string(from: dateFloat)
        print(dateValue)
        purchaseDateTF.text = dateValue
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
        equipmentValue = (userContract!.equipmentDetails!)
        
        taxImageURl = (userContract?.taxReturnImages!)!
        bankImageURl = (userContract?.bankStatements!)!
         equipmentImageURl = (userContract?.equipmentImages!)!
         insuranceImageURl = userContract?.insuranceCertificate!
         signorImageURl = userContract?.signorAndSecretaryId!
         invoiceImageURl = userContract?.invoice!
         closingImageURl = userContract?.closingFees!
        pageSignedImageURl = userContract?.allPagesSignedImage!
         everythingImageURl = userContract?.everyThingCompleted!
        
        
        if equipmentValue.count > 1{
            
            let text = "\(equipmentValue[0]), \(equipmentValue.count - 1) more"
            equipmentTF.text = text
        }
        else if equipmentValue.count == 1{
            equipmentTF.text = equipmentValue[0]
        }
        
        
        
        
       
        
        
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
        
        
        
        
        amountTF.delegate = self
        contactTF.delegate = self
        purchaseDateTF.delegate = self
        let typeButton = UITapGestureRecognizer(target: self, action: #selector(typeSegue))
        
        self.contractTypeTF.addGestureRecognizer(typeButton)
        
        let equipmentButton = UITapGestureRecognizer(target: self, action: #selector(equipmentSegue))
        
        self.equipmentTF.addGestureRecognizer(equipmentButton)
        
        let amountButton = UITapGestureRecognizer(target: self, action: #selector(amountEdit))
        
        self.amountTF.addGestureRecognizer(amountButton)
        
        
        
        let ratingButton = UITapGestureRecognizer(target: self, action: #selector(ratingEdit))
        
        self.ratingStar.addGestureRecognizer(ratingButton)
        
        
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
    
    
    
    
    
    // ***************** TEXTFIELD BEGIN EDITING  **********************

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.editStatus = true
        saveButton.isHidden = false



        return true
    }
    
    
    
    
    // ***************** VIEW WILL APPEAR **********************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    // *****************  EDIT BUTTON ACTION **********************

    
    @IBAction func editAction(_ sender: Any) {
        
        mainVIew.isUserInteractionEnabled = false
        activityView.isHidden = false
        
        self.totalImageAdded = taxImage.count + bankImage.count + equipmentImage.count + insuranceImageCount + signorImageCount + invoiceImageCount + closingImageCount + pageSignedImageCount + everythingImageCount
        
        
        //        print(self.totalImageAdded)
        
        
        // ------------- NO IMAGE ------------------
        if self.totalImageAdded == 0 {
            self.saveData()
        }
            
            
            
            
            
            
        else {
            
            // --------------- INSURANCE IMAGE UPLOAD ---------------------
            
            
            if let sendImage = insuranceImage {
                
                let image = sendImage
                let imgData = image.jpegData(compressionQuality: 0.5)
                let param = ["image":image]
                
                
                uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                    
                    
                    self.uploadCount += successCount!
                    print("*****************")
                    
//                    print(imageURL)
                    self.insuranceImageURl = imageURL!
                    
                    
                    print("*****************")
                    if self.uploadCount == self.totalImageAdded{
                        print("DONE")
                        self.saveData()
                    }
                    else{
                        print("waiting")
                    }
                }
                
            }
            
            
            
            
            
            
            // ------------ SIGNOR IMAGE UPLOAD ---------------
            if let sendImage = signorImage {
                
                let image = sendImage
                let imgData = image.jpegData(compressionQuality: 0.5)
                let param = ["image":image]
                
                
                uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                    
                    
                    self.uploadCount += successCount!
                    print("*****************")
                    
//                    print(imageURL)
                    self.signorImageURl = imageURL!
                    
                    
                    print("*****************")
                    if self.uploadCount == self.totalImageAdded{
                        print("DONE")
                        self.saveData()

                    }
                    else{
                        print("waiting")
                    }
                }
                
            }
            
            
            //------------ INVOICE IMAGE UPLOAD ---------------------
            if let sendImage = invoiceImage {
                
                let image = sendImage
                let imgData = image.jpegData(compressionQuality: 0.5)
                let param = ["image":image]
                
                
                uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                    
                    
                    self.uploadCount += successCount!
                    print("*****************")
                    
//                    print(imageURL)
                    self.invoiceImageURl = imageURL!
                    
                    
                    print("*****************")
                    if self.uploadCount == self.totalImageAdded{
                        print("DONE")
                        self.saveData()

                    }
                    else{
                        print("waiting")
                    }
                }
                
            }
            
            
            
            //------------- CLOSING IMAGE UPLOAD -----------------------
            if let sendImage = closingImage {
                
                let image = sendImage
                let imgData = image.jpegData(compressionQuality: 0.5)
                let param = ["image":image]
                
                
                uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                    
                    
                    self.uploadCount += successCount!
                    print("*****************")
                    
//                    print(imageURL)
                    self.closingImageURl = imageURL!
                    
                    print("*****************")
                    if self.uploadCount == self.totalImageAdded{
                        print("DONE")
                        self.saveData()

                    }
                    else{
                        print("waiting")
                    }
                }
                
            }
            
            
            //------------ PAGE SIGNED IMAGE UPLOAD ------------
            if let sendImage = pageSignedImage {
                
                let image = sendImage
                let imgData = image.jpegData(compressionQuality: 0.5)
                let param = ["image":image]
                
                
                uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                    
                    
                    self.uploadCount += successCount!
                    print("*****************")
                    
//                    print(imageURL)
                    self.pageSignedImageURl = imageURL!
                    
                    print("*****************")
                    if self.uploadCount == self.totalImageAdded{
                        print("DONE")
                        self.saveData()

                    }
                    else{
                        print("waiting")
                    }
                }
                
            }
            
            
            
            
            
            //------------- EVERYTING IMAGE UPLOAD -------------------
            if let sendImage = everythingImage {
                
                let image = sendImage
                let imgData = image.jpegData(compressionQuality: 0.5)
                let param = ["image":image]
                
                
                uploadImageViewModel.requestWith(endUrl:"https://testingnodejss.herokuapp.com/api/upload/imgdocs", imageData: imgData, parameters: param) { (imageURL, successCount) in
                    
                    
                    self.uploadCount += successCount!
                    print("*****************")
                    
//                    print(imageURL)
                    self.everythingImageURl = imageURL!
                    
                    print("*****************")
                    if self.uploadCount == self.totalImageAdded{
                        print("DONE")
                        self.saveData()

                    }
                    else{
                        print("waiting")
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
                        
//                        print(imageURL)
                        self.taxImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.saveData()

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
                        
//                        print(imageURL)
                        self.bankImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.saveData()

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
                        
//                        print(imageURL)
                        
                        self.equipmentImageURl.append(imageURL!)
                        
                        print("*****************")
                        if self.uploadCount == self.totalImageAdded{
                            print("DONE")
                            self.saveData()

                        }
                        else{
                            print("waiting")
                        }
                    }
                    
                }
            }
        }
        
        
        
        self.saveData()
        
    }
    
    // ************* UPLOAD BUTTON ACTION ***********
    
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
    
    // *********** IMAGE PICKER FUNCTION *******************
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.saveImage(Image: selectedImage)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func saveImage( Image : UIImage){
        
        switch self.selectedImagebuttonINdex {
        case 0:
            taxImage.append(Image)
            
            taxSwitch.isOn = true
            
            
            self.taxCollectionView.reloadData()
            taxViewHeight.constant = 90
            
            
        case 1:
            bankImage.append(Image)
            bankCollectionView.reloadData()
            bankSwitch.isOn = true
            bankViewHeight.constant = 90
            
            
        case 2:
            equipmentImage.append(Image)
            equipmentCollectionVIew.reloadData()
            equipmentSwitch.isOn = true
            equipmentViewHeight.constant = 90
            
            
        case 3:
            insuranceImage = Image
            insuranceImageCount = 1
            insuranceSwitch.isOn = true
            
        case 4:
            signorImage = Image
            signorImageCount = 1
            signorSwitch.isOn = true
            
        case 5:
            invoiceImage = Image
            invoiceSwitch.isOn = true
            invoiceImageCount = 1
            
        case 6:
            closingImage = Image
            closingSwitch.isOn = true
            closingImageCount = 1
            
        case 7:
            pageSignedImage = Image
            allpageSwitch.isOn = true
            pageSignedImageCount = 1
            
        case 8:
            everythingImage = Image
            everythingSwitch.isOn = true
            everythingImageCount = 1
        default:
            return
        }
        
    }
    
    
    
    // ******************* SAVE  ACTION ***************************
    
   
    
    
    func saveData(){
        
        
        
//        print("SAVE")
        
        let apiLink = appGlobalVariable.apiBaseURL + "contracts/updatecontract"


        if contractTypeTF.text?.isEmpty == false && purchaseDateTF.text?.isEmpty == false && amountTF.text?.isEmpty == false && equipmentTF.text?.isEmpty == false && missingText.text?.isEmpty == false{

            let inputDetail : [String : Any] = ["v": 0,
                                                "id": userContract!.id!,
                                                "addedDate": "",
                                                "allPagesSignedImage": pageSignedImageURl ?? "",
                                                "allPendingDocumentCounts": 0,
                                                "bankStatements": bankImageURl ,
                                                "closingFees": closingImageURl ?? "",
                                                "contactId": userContract!.contactId!,
                                                "contractNumber": userContract!.contractNumber!,
                                                "contractStatus": contractTypeTF.text!,
                                                "equipmentCost": amountTF.text!,
                                                "equipmentDetails": equipmentValue,
                                                "equipmentImages": equipmentImageURl ,
                                                "everyThingCompleted": everythingImageURl ?? "",
                                                "insuranceCertificate": insuranceImageURl ?? "",
                                                "invoice": invoiceImageURl ?? "",
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
                                                "projectedPurchaseDate": String((floor(date.timeIntervalSince1970) * 1000)),
                                                "rating": String(Int(ratingStar.value)),
                                                "signorAndSecretaryId": signorImageURl ?? "",
                                                "taxReturnImages": taxImageURl,
                                                "userId": appGlobalVariable.userID
            ]


            print("-------------------------")
            
            print(selectedContactID)
            print(inputDetail)
//            print(apiLink)
//
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
//            print(indexPath.row)
//            
//            print("*******************")
//            print(taxImage[indexPath.row])
//            print("*******************")
            
            
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
          
        }
        
        
        if textField == amountTF{
            amountTF.text = "$ "
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
    
    
    
    // ********** CANCEL BUTTON ACTION *****************
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




