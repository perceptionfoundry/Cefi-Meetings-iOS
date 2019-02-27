//
//  MainPendingVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainPendingVC: UIViewController, UITableViewDataSource,UITableViewDelegate {

    
    // ****************** OUTLET ***************************

    @IBOutlet weak var pendingQuantity: UILabel!
    @IBOutlet weak var pending_Table: UITableView!
    
    
    
    
    // ****************** VIEWDIDLOAD ***************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pending_Table.delegate = self
        pending_Table.dataSource = self
        
        pending_Table.reloadData()
        

    }
    
    
    
    // ****************** VIEWWILLAPPEAR ***************************

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    
    
    // ****************** TABLEVIEW DELEGATE PROTOCOL FUNCTION ***************************

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pending", for: indexPath) as! Pending_TableViewCell
        
        return cell
    }
  

}
