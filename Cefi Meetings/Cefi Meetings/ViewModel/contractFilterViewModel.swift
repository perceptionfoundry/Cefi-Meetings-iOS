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
    
    
    
    
    func contractFiltering(API : String, TextFields : [String:Any], completion : @escaping(_ Status:Bool?, _ Result: [Contract]?)->()){
        
        
        Alamofire.request(API, method: .post, parameters: TextFields).responseJSON { (resp) in
            
                        print(API)
                        print(TextFields)
            
            let fetchValue = resp.result.value as! [String:Any]
            
            
                                     print(fetchValue)
            
            guard let list = fetchValue["searchData"] as? [Any] else{return}
            
            var finalDict = [Contract]()
            
            if fetchValue["success"] as! Double == 1{
                do {
                    let json = try JSONSerialization.data(withJSONObject: list, options: JSONSerialization.WritingOptions.prettyPrinted)
                    
                    finalDict = try JSONDecoder().decode([Contract].self, from: json)
                    
                }
                catch{}
                
                
                completion(true, finalDict)
            }
        }
        
    }
    
    
    
    
    
}
