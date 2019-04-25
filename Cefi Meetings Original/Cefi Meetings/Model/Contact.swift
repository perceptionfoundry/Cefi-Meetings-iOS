//
//  Contact.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 11, 2019

import Foundation

struct Contact : Codable {

        let v : Int?
        let id : String?
        let addedDate : String?
        let businessName : String?
        let contactName : String?
        let contactType : String?
        let email : String?
        let industryType : String?
        let isActive : Bool?
        let lat : String?
        let longField : String?
        let pendingDocuments : Int?
        let phoneNumber : Int?
        let referredBy : String?
        let totalContracts : Int?
        let userId : String?

        enum CodingKeys: String, CodingKey {
                case v = "__v"
                case id = "_id"
                case addedDate = "addedDate"
                case businessName = "businessName"
                case contactName = "contactName"
                case contactType = "contactType"
                case email = "email"
                case industryType = "industryType"
                case isActive = "isActive"
                case lat = "lat"
                case longField = "long"
                case pendingDocuments = "pendingDocuments"
                case phoneNumber = "phoneNumber"
                case referredBy = "referredBy"
                case totalContracts = "totalContracts"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                v = try values.decodeIfPresent(Int.self, forKey: .v)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                addedDate = try values.decodeIfPresent(String.self, forKey: .addedDate)
                businessName = try values.decodeIfPresent(String.self, forKey: .businessName)
                contactName = try values.decodeIfPresent(String.self, forKey: .contactName)
                contactType = try values.decodeIfPresent(String.self, forKey: .contactType)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                industryType = try values.decodeIfPresent(String.self, forKey: .industryType)
                isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
                lat = try values.decodeIfPresent(String.self, forKey: .lat)
                longField = try values.decodeIfPresent(String.self, forKey: .longField)
                pendingDocuments = try values.decodeIfPresent(Int.self, forKey: .pendingDocuments)
                phoneNumber = try values.decodeIfPresent(Int.self, forKey: .phoneNumber)
                referredBy = try values.decodeIfPresent(String.self, forKey: .referredBy)
                totalContracts = try values.decodeIfPresent(Int.self, forKey: .totalContracts)
                userId = try values.decodeIfPresent(String.self, forKey: .userId)
        }

}
