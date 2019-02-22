//
//  DashboardViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 22/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire



class DashboardViewModel{
    
    
    func populateCounts(API : String, TextFields : [String:String], completion : @escaping(_ Status:Bool?, _ Result: [String:Any]?)->()){
        
        
        Alamofire.request(API, method: .post, parameters: TextFields).responseJSON { (resp) in
            
            let fetchValue = resp.result.value as! [String:Any]
            
            
//             print(fetchValue)
            
            if fetchValue["success"] as! Double == 1{
                
                completion(true, fetchValue)
            }
        }
        
    }
    
}
