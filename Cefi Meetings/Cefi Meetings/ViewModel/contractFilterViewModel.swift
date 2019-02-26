//
//  contractFilterViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 26/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire

class contractFilterViewModel{
    
    
    
    
    func contractFiltering(API : String, TextFields : [String:Any], completion : @escaping(_ Status:Bool?, _ Result: [Contract]?, _ message : String?)->()){
        
        
        Alamofire.request(API, method: .post, parameters: TextFields).responseJSON { (resp) in
            
            
            
//            print("************ INPUT value to API ********************")
//
//                        print(API)
//                        print(TextFields)
//            print(" **************************************************")

            
            let fetchValue = resp.result.value as! [String:Any]
            
       print("\n ************ SERVER RESPONSE ********************")
                                     print(fetchValue)
            print("***********************************")
            
            guard let list = fetchValue["searchData"] as? Any else{return}
            
            var finalDict = [Contract]()
            
            
            print("***********************************")

            print(list)
            print("***********************************")

            
            
            
            if fetchValue["success"] as! Double == 1{
                do {
                    let json = try JSONSerialization.data(withJSONObject: [list], options: JSONSerialization.WritingOptions.prettyPrinted)
                    
                    finalDict = try JSONDecoder().decode([Contract].self, from: json)
                    
                    
                    finalDict.first?.contractNumber
                }
                catch{}
                
                
                print(finalDict.count)
                
                completion(true, finalDict, nil)
            }
            else if fetchValue["success"] as! Double == 0{
                completion(false,nil,fetchValue["status"] as! String)
            }
        }
        
    }
    
    
    
    
    
}
