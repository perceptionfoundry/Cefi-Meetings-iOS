//
//  MainContractsVC.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/01/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import UIKit

class MainContractsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var NaviBar: UINavigationBar!

    @IBOutlet weak var contract_Table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contract_Table.delegate = self
        contract_Table.dataSource = self
        
        
        // Making navigation bar transparent
        NaviBar.setBackgroundImage(UIImage(), for: .default)
        NaviBar.shadowImage = UIImage()
        
        contract_Table.reloadData()

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contract", for: indexPath) as! Contract_TableViewCell
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "Contract_Detail")
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
  
    @IBAction func addContractAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Contract", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "New_Contract")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
