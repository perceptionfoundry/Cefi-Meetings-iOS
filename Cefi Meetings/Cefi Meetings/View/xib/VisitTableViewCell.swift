//
//  VisitTableViewCell.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 29/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit
import HCSStarRatingView

class VisitTableViewCell: UITableViewCell {

    @IBOutlet weak var topView: Custom_View!
    @IBOutlet weak var bottomView: Custom_View!
    
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var ratingStar: HCSStarRatingView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var callNowButton: UIButton!
    
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var bottomDetailButton: UIButton!
    @IBOutlet weak var bottomStartButton: UIButton!
    
}
