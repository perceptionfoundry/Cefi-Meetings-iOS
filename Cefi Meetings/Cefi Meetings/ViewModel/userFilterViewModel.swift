//
//  userFilterViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 22/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire

class userFilterViewModel{
    
    
    func userFiltering(API : String, TextFields : [String:String], completion : @escaping(_ Status:Bool?, _ Result: [Contact]?, _ message : String?)->()){
        
        
        Alamofire.request(API, method: .post, parameters: TextFields).responseJSON { (resp) in
            
//            print(API)
//            print(TextFields)
            
            let fetchValue = resp.result.value as! [String:Any]
            
            
            print(fetchValue["success"])
            print(fetchValue["status"])

            
            var status  = false
            
            if fetchValue["success"] as! Int == 1 {
                status = true
            }
            else {
                status = false
            }
            
            
            print(status)
            
//            guard let list = fetchValue["searchData"] as? [Any] else{return}
            
            var finalDict = [Contact]()
            
       
            
            
            
            if status == true {
                guard let list = fetchValue["searchData"] as? [Any] else{return}

                do {
                    let json = try JSONSerialization.data(withJSONObject: list, options: JSONSerialization.WritingOptions.prettyPrinted)
                    
                    finalDict = try JSONDecoder().decode([Contact].self, from: json)

                }
                catch{}
                
                
                completion(true, finalDict, nil)
            }
            
            else {
                completion(false,nil,fetchValue["status"] as! String)
            }
        }
        
    }
    
}
