//
//  NewContactViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 16/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire


class NewContactViewModel{
    
//    var userDetail : Contact!

    

    func newContactCreate (API : String, Textfields : [String : Any], completion:@escaping(_ loginStatus:Bool,_ errorDescription:String?)->Void){

     
        
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .post, parameters: Textfields, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            
            // fetching response result from API
            guard let value = response.result.value  as? [String : Any] else{return}

           
            
            // Storing Server status
            let check  = value["success"] as? Double
            
            
            
            // ************* Action to taken as per server response ******************
            
            // ERROR OCCUR
            if check == 0 {
                
                
                guard let errorValue =  value["errors"] as? [String : String] else {return}
                
                
                let errMessage = errorValue.values.first!
                
                
                completion(false, errMessage)
                
                
            }
                
                // NO ERROR OCCUR
            else{
                completion(true, nil)
            }
            
        }
        
        
    }
    
    
    
}
