//
//  ReferralNewContactVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 31/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import HCSStarRatingView
import TagListView





class ReferralNewContractVC: UIViewController, typeDelegate, contactdelegate, UITextFieldDelegate {
    
    @IBOutlet weak var contractTypeTF: UITextField!
    @IBOutlet weak var contractNumberTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var purchaseDateTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var ratingStar: HCSStarRatingView!
    
    @IBOutlet weak var tagView: TagListView!
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
        
        tagView.delegate = self
        
        contactTF.delegate = self
        tagTF.delegate = self
        
        let typeButton = UITapGestureRecognizer(target: self, action: #selector(typeSegue))
        
        self.contractTypeTF.addGestureRecognizer(typeButton)
        
        
        
        
        
    }
    
    @objc func typeSegue(){
        performSegue(withIdentifier: "Type", sender: nil)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == contactTF{
            //
            
            performSegue(withIdentifier: "Contact", sender: nil)
        }
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tagTF{
            
            if tagTF.text?.isEmpty != true && tagArray.contains(tagTF.text!) != true{
                
                tagView.addTag(tagTF.text!)
                tagArray.append(tagTF.text!)
                tagTF.endEditing(true)
                tagTF.text = ""
                tagTF.clearsOnBeginEditing = true
                
                print(tagArray)
                
            }
        }
        
        return true
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
    
    
    
    
    
    
    @IBAction func tagAddButton(_ sender: Any) {
        
        if tagTF.text?.isEmpty != true && tagArray.contains(tagTF.text!) != true{
            
            tagView.addTag(tagTF.text!)
            tagArray.append(tagTF.text!)
            tagTF.endEditing(true)
            tagTF.text = ""
            tagTF.clearsOnBeginEditing = true
            
            print(tagArray)
            
        }
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension ReferralNewContractVC: TagListViewDelegate{
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        let index = tagArray.firstIndex(of: title)
        
        tagArray.remove(at: index!)
        sender.removeAllTags()
        sender.addTags(tagArray)
        
        
    }
    
}
