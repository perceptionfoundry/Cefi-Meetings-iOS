//
//  NewPasswordViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 25/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire

class NewPasswordViewModel{
    
    
    
    func newPassword (API : String, Textfields : [String : Any], completion:@escaping(_ loginStatus:Bool,_ errorDescription:String?)->Void){
        
        //
        //        print(API)
                print(Textfields)
        
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .post, parameters: Textfields, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
//            print(API)
            
//            print(response.result.value)
            
            // fetching response result from API
            guard let value = response.result.value  as? [String : Any] else{return}
            
            
            
            // Storing Server status
            let check  = value["success"] as? Int
            
            
//            print(check)
//            print( value["status"])
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
