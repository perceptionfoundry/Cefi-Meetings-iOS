//
//  Contact.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 30, 2019

import Foundation

struct Contact : Codable {

        let v : Int?
        let id : String?
        let addedDate : String?
        let businessName : String?
        let contactName : String?
        let contactType : String?
        let email : String?
        let industryType : [String]?
        let isActive : Bool?
        let lat : String?
        let longField : String?
        let pendingDocuments : Int?
        let phoneNumber : Int?
        let referredBy : String?
        let state : String?
        let streetAddress : String?
        let totalContracts : Int?
        let town : String?
        let userId : String?
        let visitId : String?

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
                case state = "state"
                case streetAddress = "streetAddress"
                case totalContracts = "totalContracts"
                case town = "town"
                case userId = "userId"
                case visitId = "visitId"
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
                industryType = try values.decodeIfPresent([String].self, forKey: .industryType)
                isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
                lat = try values.decodeIfPresent(String.self, forKey: .lat)
                longField = try values.decodeIfPresent(String.self, forKey: .longField)
                pendingDocuments = try values.decodeIfPresent(Int.self, forKey: .pendingDocuments)
                phoneNumber = try values.decodeIfPresent(Int.self, forKey: .phoneNumber)
                referredBy = try values.decodeIfPresent(String.self, forKey: .referredBy)
                state = try values.decodeIfPresent(String.self, forKey: .state)
                streetAddress = try values.decodeIfPresent(String.self, forKey: .streetAddress)
                totalContracts = try values.decodeIfPresent(Int.self, forKey: .totalContracts)
                town = try values.decodeIfPresent(String.self, forKey: .town)
                userId = try values.decodeIfPresent(String.self, forKey: .userId)
                visitId = try values.decodeIfPresent(String.self, forKey: .visitId)
        }

}
