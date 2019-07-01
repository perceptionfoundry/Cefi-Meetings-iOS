//
//  NewMeetingViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 06/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire


class NewMeetingViewModel{
    
    //    var userDetail : Contact!
    
    
    
    func newMeetingCreate (API : String, Textfields : [String : Any], completion:@escaping(_ loginStatus:Bool,_ errorDescription:String?, _ resultData:[String : Any]?)->Void){
        
        
//
        
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .post, parameters: Textfields, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            
            
            print(API)
            print(Textfields)
            
           print(response.result.value)
            
            // fetching response result from API
           guard let value = response.result.value  as? [String : Any] else{return}
            
            
            
            // Storing Server status
            let check  = value["success"] as? Double
            
            
            
            // ************* Action to taken as per server response ******************
            
            // ERROR OCCUR
            if check == 0 {
                
                
                guard let errorValue =  value["status"] as? [String : String] else {return}
                
                
                let errMessage = errorValue.values.first!
                
                
                completion(false, errMessage, nil)
                
                
            }
                
                // NO ERROR OCCUR
            else{
                
                 guard let fetchValue =  value["visitData"] as? [String : Any] else {return}
                
                
                completion(true, nil, fetchValue)
            }
            
        }
        
        
    }
    
    
    
}
