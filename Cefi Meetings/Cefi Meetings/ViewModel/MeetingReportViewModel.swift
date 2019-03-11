//
//  MeetingReportViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 11/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire


class MeetingReportViewModel{
    
    func addReport(API: String, Param: [String:String], Completion: @escaping (_ status : Bool, _ error : String?)->()){
        
        print(API)
        print(Param)
        
        
        Alamofire.request(API, method: .post, parameters: Param, encoding: JSONEncoding.default, headers: nil).responseJSON { (resp) in
            
            guard let value = resp.result.value  as? [String:String] else{return}
            
            print(value)
            
            if value["success"] as! Int == 1{
                
                
                
                Completion(true,nil)
                
            }
                
            else{
                Completion(false,"error")
            }
            
        }
    }
    
    
}
