//
//  EditDealerPersonViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 01/04/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire


class EditDealerPersonViewModel{
    
    func addPerson(API: String, Param: [String:String], Completion: @escaping (_ status : Bool, _ error : String?)->()){
        
        
        
        Alamofire.request(API, method: .put, parameters: Param, encoding: JSONEncoding.default, headers: nil).responseJSON { (resp) in
            
            guard let value = resp.result.value  as? [String:Any] else{return}
            
            
            if value["success"] as! Int == 1{
                
                
                
                Completion(true,nil)
                
            }
                
            else{
                Completion(false,"error")
            }
            
        }
    }
    
    
}
