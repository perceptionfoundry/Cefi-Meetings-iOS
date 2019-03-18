//
//  UserSettingViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 18/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//




import Foundation
import Alamofire



class UserSettingViewModel{
    
    
    
    
    func fetchUserProfile(API: String, TextFields: [String : String] ,completion : @escaping(_ Status:Bool,_ Message:String?, _ Result : Profile)->()){
        
        Alamofire.request(API, method: .get, parameters: TextFields).responseJSON { (response) in
            
            guard let mainDict = response.result.value  as? [String : Any] else{return}
            
            
//            print(mainDict["userData"])
            
            if mainDict["success"] as! Int == 1 {
                
                let contactList = mainDict["userData"] as? Any
                
                
                var jsonData : Data?
                
                var finalDict : Profile?
                
                do{
                    jsonData = try JSONSerialization.data(withJSONObject: contactList, options: JSONSerialization.WritingOptions.prettyPrinted)
                }catch{print("JSON Writing Error")}
                
                
                do{
                    
                    finalDict = try JSONDecoder().decode(Profile.self, from: jsonData!)
                    
                    //                print(finalDict.count)
                    
                    
                    completion(true,"",finalDict!)
                    
                    
                }catch{print("JSON Decoding error")}
            }
        }
    }
    
}
