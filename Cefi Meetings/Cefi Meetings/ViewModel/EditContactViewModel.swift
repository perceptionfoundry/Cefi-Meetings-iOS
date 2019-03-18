//
//  EditContactViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation


import Foundation
import Alamofire


class EditContactViewModel{
    
    //    var userDetail : Contact!
    
    
    
    func editContact (API : String, Textfields : [String : Any], completion:@escaping(_ loginStatus:Bool,_ errorDescription:String?, _ result: Contact?)->Void){
        
//
//                print(API)
//                print(Textfields)
        
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .put, parameters: Textfields, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            
            // fetching response result from API
            
//            print(response.result.value)
            
            var value = response.result.value  as! [String : Any]
            
//            print(value)
            
            // Storing Server status
            let check  = value["success"] as? Double
            
            
            //            print(check)
            
            // ************* Action to taken as per server response ******************
            
            // ERROR OCCUR
            if check == 0 {
                
                
                guard let errorValue =  value["errors"] as? [String : String] else {return}
                
                
                let errMessage = errorValue.values.first!
                
                
                completion(false, errMessage, nil)
                
                
            }
                
                // NO ERROR OCCUR
            else{
                
                guard let editValue = value["userContact"] as? Any else{return}
                
                
                var jsonData : Data?
                
                var finalDict : Contact?
                
                do{
                    jsonData = try JSONSerialization.data(withJSONObject: editValue, options: JSONSerialization.WritingOptions.prettyPrinted)
                }catch{print("JSON Writing Error")}
                
                
                do{
                    
                    finalDict = try JSONDecoder().decode(Contact.self, from: jsonData!)
                    
//                    print(finalDict)
                    
                    completion(true, nil, finalDict )

                    
                    
                }catch{print("JSON Decoding error")}
                
//                completion(true, nil, value["userContact"] )
            }
            
        }
        
        
    }
    
    
    
}
