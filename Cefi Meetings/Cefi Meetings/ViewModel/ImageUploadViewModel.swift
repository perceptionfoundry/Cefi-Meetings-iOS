//
//  ImageUploadViewModel.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 14/03/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation
import Alamofire



class ImageUploadViewModel{
    
    
    
    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((String?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil, countCompletion: @escaping(_ url : String? ,_ successCount : Int?)->()){
        
        let url = "https://testingnodejss.herokuapp.com/api/upload/imgdocs" /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "application/json"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
//                    print("response = \(response.result.value)")
                   
                    let result = response.result.value as! [String:Any]
                    
                    
                    let link = result["url"] as! String
                    let successValue = result["success"] as! Int
                    
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?(nil)
                    countCompletion(link, successValue)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
    
    
}
