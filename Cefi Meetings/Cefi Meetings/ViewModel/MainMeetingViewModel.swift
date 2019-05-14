//
//  MainMeetingViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 07/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire


class MainMeetingViewModel{
    
    func getTodayVisitDetail(API: String, Param : [String : Any], completion : @escaping(_ status : Bool, _ err : String?, _ result : [Meeting]?)->() ){
        
        
   
        
        
        // ****** Hitting ApiLink with required parameter **********
        
        Alamofire.request(API, method: .get).responseJSON { (resp) in
            
            
            
            print(API)
            print(Param)
            
            print(resp.result.value)
            
            guard let value = resp.result.value as?  [String:Any] else {return}
            
            
            if value["success"] as! Int == 1{
                
                let meetingValue = value["visitData"] as! [Any]
                
                
                var jsonData : Data?
                
                var finalDict = [Meeting]()
                
                do{
                    jsonData = try JSONSerialization.data(withJSONObject: meetingValue, options: JSONSerialization.WritingOptions.prettyPrinted)
                }catch{print("JSON Writing Error")}
                
                
                do{
                    
                    finalDict = try JSONDecoder().decode([Meeting].self, from: jsonData!)
                    
                    
                    
                    completion(true,"",finalDict)
                    
                    
                }catch{print("JSON Decoding error")}
                
                
                
            }
            else{
                completion(false,"",nil)

            }
        }
    }
    
}
