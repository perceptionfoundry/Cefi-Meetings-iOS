//
//  NewContractVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 30/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import HCSStarRatingView


protocol typeDelegate {
    func typeName(name : String)
}

protocol contactdelegate {
    func contactName(userName : String)
}


class NewContractVC: UIViewController, typeDelegate, contactdelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
 
    

    
    
    @IBOutlet weak var taxCollectionView: UICollectionView!
    
    @IBOutlet weak var bankCollectionView: UICollectionView!
    
    @IBOutlet weak var equipmentCollectionVIew: UICollectionView!
    
    @IBOutlet weak var contractTypeTF: UITextField!
    @IBOutlet weak var contractNumberTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var purchaseDateTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var ratingStar: HCSStarRatingView!
    
    
    
    @IBOutlet weak var taxView: UIView!
    @IBOutlet weak var taxViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bankStateView: UIView!
    @IBOutlet weak var bankViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var equipmentView: UIView!
    @IBOutlet weak var equipmentViewHeight: NSLayoutConstraint!
    
//    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var tagTF: UITextField!
    
    var tagArray = [String]()
    
    
    // ********** Implement protocol function ******************
    func typeName(name: String) {
        self.contractTypeTF.text = name
    }
    
    func contactName(userName: String) {
        contactTF.text = userName
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

        
       
        
//        tagView.delegate = self
        
        contactTF.delegate = self
//        tagTF.delegate = self
        
        let typeButton = UITapGestureRecognizer(target: self, action: #selector(typeSegue))

        self.contractTypeTF.addGestureRecognizer(typeButton)
        
        
        
       

    }
    
    
    
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
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
       
    }
    
    
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
    
  
    
    @IBAction func doneButtonAction(_ sender: Any) {
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}


//
//extension NewContractVC: TagListViewDelegate{
//
//    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
//
//        let index = tagArray.firstIndex(of: title)
//
//        tagArray.remove(at: index!)
//        sender.removeAllTags()
//        sender.addTags(tagArray)
//
//
//    }
//
//}
