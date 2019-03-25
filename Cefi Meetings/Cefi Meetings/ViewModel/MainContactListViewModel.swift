//
//  MainContactListViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 20/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire



class MainContactListViewModel{
    
    
    
    
    func fetchContactDetail(API: String, TextFields: [String : String] ,completion : @escaping(_ Status:Bool,_ Message:String?, _ Result : [Contact])->()){
        
        Alamofire.request(API, method: .post, parameters: TextFields).responseJSON { (response) in
            
            guard let mainDict = response.result.value  as? [String : Any] else{return}
            
            
            
            if mainDict["status"] as! String != "Sorry contracts not exist" {
            
            let contactList = mainDict["userContact"] as! [Any]
            
            
            var jsonData : Data?
            
            var finalDict = [Contact]()
            
            do{
            jsonData = try JSONSerialization.data(withJSONObject: contactList, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch{print("JSON Writing Error")}
            
            
            do{
                
                finalDict = try JSONDecoder().decode([Contact].self, from: jsonData!)
                

                
                completion(true,"",finalDict)
                
            
            }catch{print("JSON Decoding error")}
        }
    }
    }
    
}
