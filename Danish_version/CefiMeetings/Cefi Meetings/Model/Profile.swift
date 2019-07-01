//
//  Profile.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on April 2, 2019

import Foundation

struct Profile : Codable {

        let v : Int?
        let id : String?
        let addedBy : String?
        let addedDate : String?
        let email : String?
        let forgetPaswordCode : String?
        let isActive : Bool?
        let name : String?
        let phoneNumber : Int?
        let totalContacts : Int?
        let totalContracts : Int?
        let totalVisits : Int?

        enum CodingKeys: String, CodingKey {
                case v = "__v"
                case id = "_id"
                case addedBy = "addedBy"
                case addedDate = "addedDate"
                case email = "email"
                case forgetPaswordCode = "forgetPaswordCode"
                case isActive = "isActive"
                case name = "name"
                case phoneNumber = "phoneNumber"
                case totalContacts = "totalContacts"
                case totalContracts = "totalContracts"
                case totalVisits = "totalVisits"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                v = try values.decodeIfPresent(Int.self, forKey: .v)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                addedBy = try values.decodeIfPresent(String.self, forKey: .addedBy)
                addedDate = try values.decodeIfPresent(String.self, forKey: .addedDate)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                forgetPaswordCode = try values.decodeIfPresent(String.self, forKey: .forgetPaswordCode)
                isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                phoneNumber = try values.decodeIfPresent(Int.self, forKey: .phoneNumber)
                totalContacts = try values.decodeIfPresent(Int.self, forKey: .totalContacts)
                totalContracts = try values.decodeIfPresent(Int.self, forKey: .totalContracts)
                totalVisits = try values.decodeIfPresent(Int.self, forKey: .totalVisits)
        }

}
