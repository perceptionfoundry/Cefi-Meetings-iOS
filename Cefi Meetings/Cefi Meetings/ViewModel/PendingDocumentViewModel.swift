//
//  PendingDocumentViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 15/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//





import Foundation
import Alamofire



class PendingDocumentViewModel{
    
    
    
    
    func fetchPendingDocument(API: String, TextFields: [String : String] ,completion : @escaping(_ Status:Bool,_ Message:String?, _ Result : [Pending])->()){
        
        
        
        Alamofire.request(API, method: .get, parameters: TextFields).responseJSON { (response) in
            
            
            
            guard let mainDict = response.result.value  as? [String : Any] else{return}
            
            
            if mainDict["success"] as! Int == 1 {
                
                let contactList = mainDict["contractData"] as! [Any]
                
                
                var jsonData : Data?
                
                var finalDict = [Pending]()
                
                do{
                    jsonData = try JSONSerialization.data(withJSONObject: contactList, options: JSONSerialization.WritingOptions.prettyPrinted)
                }catch{print("JSON Writing Error")}
                
                
                do{
                    
                    finalDict = try JSONDecoder().decode([Pending].self, from: jsonData!)
                    
                    
                    
                    completion(true,"",finalDict)
                    
                    
                }catch{print("JSON Decoding error")}
            }
        }
    }
    
}
