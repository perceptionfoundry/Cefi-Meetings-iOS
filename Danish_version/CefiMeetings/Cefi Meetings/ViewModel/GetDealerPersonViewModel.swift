//
//  GetDealerPersonViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 13/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//



import Foundation
import Alamofire



class GetDealerPersonViewModel{
    
    
    
    
    func fetchDealerPersont(API: String, TextFields: [String : String] ,completion : @escaping(_ Status:Bool,_ Message:String?, _ Result : [Dealer])->()){
        
        Alamofire.request(API, method: .post, parameters: TextFields).responseJSON { (response) in
            
            guard let mainDict = response.result.value  as? [String : Any] else{return}
            
            
            
            if mainDict["success"] as! Int == 1 {
                
                let contactList = mainDict["dealer"] as! [Any]
                
                
                var jsonData : Data?
                
                var finalDict = [Dealer]()
                
                do{
                    jsonData = try JSONSerialization.data(withJSONObject: contactList, options: JSONSerialization.WritingOptions.prettyPrinted)
                }catch{print("JSON Writing Error")}
                
                
                do{
                    
                    finalDict = try JSONDecoder().decode([Dealer].self, from: jsonData!)
                    
                    
                    
                    completion(true,"",finalDict)
                    
                    
                }catch{print("JSON Decoding error")}
            }
        }
    }
    
}
