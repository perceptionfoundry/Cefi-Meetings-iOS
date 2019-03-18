//
//  NewContractViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 18/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire


class NewContractViewModel {
    
    
    func newContractCreate (API : String, Textfields : [String : Any], completion:@escaping(_ loginStatus:Bool,_ errorDescription:String?)->Void){
        
        
//        print(API)
//        print(Textfields)
        
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .post, parameters: Textfields, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            
            // fetching response result from API
            guard let value = response.result.value  as? [String : Any] else{

                return}
  
//            print(value)
            // Storing Server status
            let check  = value["success"] as? Double
            
            
//                        print(check)
            
            // ************* Action to taken as per server response ******************
            
            // ERROR OCCUR
            if check == 0 {
                
                
                let errorValue =  value["status"] as! String
                
                
                let errMessage = errorValue
                
                
                completion(false, errMessage)
                
                
                
            }
                
                // NO ERROR OCCUR
            else{
                completion(true, nil)
            }
            
        }
        
        
    }
    
}
