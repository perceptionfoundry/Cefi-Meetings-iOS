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
        
        
 
        
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .post, parameters: Textfields, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            
            
//            print(API)
            print(Textfields)
//            print(response.result.value)
            
            // fetching response result from API
            guard let value = response.result.value  as? [String : Any] else{

                return}
  
            
            // Storing Server status
            let check  = value["success"] as? Double
            
            
            
            // ************* Action to taken as per server response ******************
            
            // ERROR OCCUR
            if check == 0 {
                
                
                let errorValue =  value["status"] as! String
                
                
                let errMessage = errorValue
                
                
                completion(false, errMessage)
                
                
                
            }
                
                // NO ERROR OCCUR
            else{
                
                
                guard let contractList = value["contractData"] as? Any else{return}
                
                
                var jsonData : Data?
                
                var finalDict : Contract?
                
                do{
                    jsonData = try JSONSerialization.data(withJSONObject: contractList, options: JSONSerialization.WritingOptions.prettyPrinted)
                }catch{print("JSON Writing Error")}
                
                
                do{
                    
                    finalDict = try JSONDecoder().decode(Contract.self, from: jsonData!)
                    
                    
                    
                    completion(true, finalDict!.contractNumber!)
                    
                }catch{print("JSON Decoding error")}
                
                
//
            }
            
        }
        
        
    }
    
}
