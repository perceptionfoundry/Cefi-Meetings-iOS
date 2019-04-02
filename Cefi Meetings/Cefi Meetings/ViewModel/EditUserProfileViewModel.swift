//
//  EditUserProfileViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 02/04/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//




import Foundation
import Alamofire



class EditUserProfileViewModel{
    
    
    
    
    func editUserProfile(API: String, TextFields: [String : String] ,completion : @escaping(_ Status:Bool,_ Message:String?, _ Result : Profile)->()){
        
        
        print(API)
        print(TextFields)
        
        
        Alamofire.request(API, method: .put, parameters: TextFields).responseJSON { (response) in
            
            
            print(response.result.value)
            
            guard let mainDict = response.result.value  as? [String : Any] else{return}
            
            
            
            if mainDict["success"] as! Int == 1 {
                
                let contactList = mainDict["userData"] as? Any
                
                
                var jsonData : Data?
                
                var finalDict : Profile?
                
                do{
                    jsonData = try JSONSerialization.data(withJSONObject: contactList, options: JSONSerialization.WritingOptions.prettyPrinted)
                }catch{print("JSON Writing Error")}
                
                
                do{
                    
                    finalDict = try JSONDecoder().decode(Profile.self, from: jsonData!)
                    
                    
                    
                    completion(true,"",finalDict!)
                    
                    
                }catch{print("JSON Decoding error")}
            }
        }
    }
    
}



