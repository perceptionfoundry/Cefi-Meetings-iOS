//
//  contractFilterVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 30/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TTSegmentedControl
import SwiftRangeSlider
import HCSStarRatingView



class contractFilterVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    // ********** Outlet *********************
    @IBOutlet weak var NaviBar: UINavigationBar!
    @IBOutlet weak var filterTable: UITableView!
    
    @IBOutlet weak var allButton: Custom_Button!
    @IBOutlet weak var openButton: Custom_Button!
    @IBOutlet weak var closedButton: Custom_Button!
    @IBOutlet weak var deadButton: Custom_Button!
    @IBOutlet weak var priceRange: RangeSlider!
    @IBOutlet weak var typeSegment: TTSegmentedControl!
    
    @IBOutlet weak var ratingStar: HCSStarRatingView!
    @IBOutlet weak var searchTF: UITextField!
    
    
    let searchResult = [Contract]()
    
   var selectedContractType = "all"
    let appGlobalVarible = UIApplication.shared.delegate as! AppDelegate
    let viewModel = contractFilterViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        filterTable.delegate = self
        filterTable.dataSource = self
        
        typeSegment.itemTitles = ["Dealers","Prospects","Clients","Referrals"]
       
        
        typeSegment.allowChangeThumbWidth = false
        
        // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        
        filterTable.reloadData()
        
    }
    
    
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        
        let apiLink = appGlobalVarible.apiBaseURL+"contracts/searchcontracts"

        
        let dataDict : [String : Any] = [
            "userId": appGlobalVarible.userID,
            "contractStatus": self.selectedContractType ,
            "rating": ratingStar.value,
            "contractStartingPrice" : priceRange!.minimumValue,
            "contractEndingPrice" : priceRange!.maximumValue,
            "searchString": searchTF.text!
    
        ]
     
        
        viewModel.contractFiltering(API: apiLink, TextFields: dataDict) { (status, result) in
            
            print(result)
            
        }
        
        
    }
    
    
    
    
    //  ******** Selection Button Action function ************************

    
    @IBAction func ListDisplayOption(_ sender: UIButton) {
        
        if sender.tag == 0{
            allButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor.clear
            self.selectedContractType = "all"
        }
        else if sender.tag == 1{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor.clear
            self.selectedContractType = "open"

        }
        else if sender.tag == 2{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            deadButton.border_color = UIColor.clear
            self.selectedContractType = "closed"

        }
        else if sender.tag == 3{
            allButton.border_color = UIColor.clear
            openButton.border_color = UIColor.clear
            closedButton.border_color = UIColor.clear
            deadButton.border_color = UIColor(red: 0.349, green: 0.568, blue: 0.227, alpha: 1)
            self.selectedContractType = "dead"

        }
    }
    
    
    
    
    // ****************** Tableview Delegate protocol functions ***************************
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contract", for: indexPath) as! Contract_TableViewCell
        
        return cell
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
