//
//  ContactContractDetail.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 28/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire



class ContactContractDetailViewModel{
    
    func fetchContractDetail(API: String, TextFields: [String : String] ,completion : @escaping(_ Status:Bool,_ Message:String?, _ Result : [Contract], _ pendingCount :Int?)->()){
        
        Alamofire.request(API, method: .post, parameters: TextFields).responseJSON { (response) in
            
            let mainDict = response.result.value  as! [String : Any]
            
            
//                        print(mainDict)
            
            if mainDict["success"] as! Int == 1 {
                
                guard let contractList = mainDict["contactContracts"] as? [Any] else{return}
                
                
                var jsonData : Data?
                
                var finalDict = [Contract]()
                
                do{
                    jsonData = try JSONSerialization.data(withJSONObject: contractList, options: JSONSerialization.WritingOptions.prettyPrinted)
                }catch{print("JSON Writing Error")}
                
                
                do{
                    
                    finalDict = try JSONDecoder().decode([Contract].self, from: jsonData!)
                    
//                    print(finalDict.count)
                    
                    
                    completion(true,"",finalDict, mainDict["totalContactsPendingDocument"] as? Int)
                    
                    
                }catch{print("JSON Decoding error")}
            }
        }
    }
    
    
    
    
    
    
    
}
