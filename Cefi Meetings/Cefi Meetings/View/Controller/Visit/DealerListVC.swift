//
//  DealerListVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 04/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class DealerListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var DealerTitle: UILabel!
    
    @IBOutlet weak var dealerListTable: UITableView!
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dealerListTable.delegate = self
        dealerListTable.dataSource = self
        
        
        dealerListTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Dealer_List", for: indexPath) as! DealerTableViewCell
        
        tableView.separatorStyle = .none
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }

    @IBAction func newDetailerAction(_ sender: Any) {
        
        performSegue(withIdentifier: "newDealer", sender: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

