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
    
    
    
    func newMeetingCreate (API : String, Textfields : [String : Any], completion:@escaping(_ loginStatus:Bool,_ errorDescription:String?)->Void){
        
        
                print(API)
                print(Textfields)
        
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .post, parameters: Textfields, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            
            // fetching response result from API
            var value = response.result.value  as! [String : Any]
            
            print(value)
            
            // Storing Server status
            let check  = value["success"] as? Double
            
            
            print(check)
            
            // ************* Action to taken as per server response ******************
            
            // ERROR OCCUR
            if check == 0 {
                
                
                guard let errorValue =  value["status"] as? [String : String] else {return}
                
                
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
