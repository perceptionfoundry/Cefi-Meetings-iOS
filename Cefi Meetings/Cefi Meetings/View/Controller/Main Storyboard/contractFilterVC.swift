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



class contractFilterVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var NaviBar: UINavigationBar!
    @IBOutlet weak var filterTable: UITableView!
    
    @IBOutlet weak var priceRange: RangeSlider!
    @IBOutlet weak var typeSegment: TTSegmentedControl!
    
    
    @IBOutlet weak var statusSegment: TTSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        filterTable.delegate = self
        filterTable.dataSource = self
        
        typeSegment.itemTitles = ["Dealers","Prospects","Clients","Referrals"]
        statusSegment.itemTitles = ["Open","Deal","Dead","Closed"]
        
        typeSegment.allowChangeThumbWidth = false
        statusSegment.allowChangeThumbWidth = false
        
        // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        
        filterTable.reloadData()
        
    }
    
    
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
