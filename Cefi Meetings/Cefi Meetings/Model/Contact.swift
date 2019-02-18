//
//  Contact.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 14/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation

//
//class Contact:Decodable{
//
//    var contactType : String?
//    var contactBusiness : String?
//    var contactName : String?
//    var contactPhone : String?
//    var contactEmail : String?
//    var contactIndustry : String?
//    var contactReferred : String?
//    var contactLat : String?
//    var contactLong : String?
//}


class Contact : Decodable{
    
    var userId : String
    var businessName : String
    var contactName : String
    var phoneNumber : String
    var email : String
    var industryType : String
    var contactType : String
    var referredBy : String
    var streetAddress : String?
    var town : String?
    var state : String?
    var lat : String
    var long : String
    var _id : String?
    var addedDate : String?
    var isActive : Bool?
    var totalContracts : Double?
    var __v : Int?
    
    
    init(userID: String, businessName: String, contactName: String, phone: String, email: String, industryType : String, ContactType: String, referredBy: String, Lat: String, long : String ){
        
        self.userId = userID
       self.businessName = businessName
        self.contactName = contactName
       self.phoneNumber = phone
        self.email = email
       self.industryType = industryType
        self.contactType = ContactType
        self.referredBy = referredBy
        self.lat = Lat
        self.long = long
        
    }
    
}
