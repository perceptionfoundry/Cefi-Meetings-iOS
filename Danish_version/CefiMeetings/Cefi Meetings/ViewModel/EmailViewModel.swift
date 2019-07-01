//
//  EmailViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire


class EmailViewModel{
    
    
    func ForgetEmail (API : String, Textfields : [String : Any], completion:@escaping(_ loginStatus:Bool,_ errorDescription:String?)->Void){
        
  
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .post, parameters: Textfields, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
         
            
            // fetching response result from API
            guard let value = response.result.value  as? [String : Any] else{return}
            
            
            
            // Storing Server status
            let check  = value["success"] as? Int
            
            
 
            // ************* Action to taken as per server response ******************
            
            // ERROR OCCUR
            if check == 0 {
                
                
                guard let errorValue =  value["status"] as? String else {return}
                
                
                let errMessage = errorValue
                
                
                completion(false, errMessage)
                
                
            }
                
                // NO ERROR OCCUR
            else{
                completion(true, value["messege"] as! String)
            }
            
        }
        
        
    }
    
    
    
    
}
