//
//  ContractDetailVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 01/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import TagListView
import HCSStarRatingView

class ContractDetailVC: UIViewController {

    
    @IBOutlet weak var purchaseDate: UILabel!
    @IBOutlet weak var equipmentCost: UILabel!
    
    @IBOutlet weak var tagView: TagListView!
    
    @IBOutlet weak var ratingVIew: HCSStarRatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        tagView.addTags(["Printing", "Healthcare","iOS Developer"])
    }
    

    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
