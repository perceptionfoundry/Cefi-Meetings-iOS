//
//  SignInViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 15/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire


class SignInViewModel{
    
    var apiURL = ""
    
    
    func signINProcess(API:String) -> Bool {
        
        
        Alamofire.request(API, method: .post, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
        
        return false
    }
    
}
