//
//  Meeting.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 14, 2019

import Foundation

struct Meeting : Codable {

        let v : Int?
        let id : String?
        let addedDate : String?
        let address : String?
        let businessName : String?
        let contactId : String?
        let contactName : String?
        let contactType : String?
        let contractId : String?
        let contractNumber : String?
        let dateInString : String?
        let email : String?
        let lat : String?
        let longField : String?
        let phoneNumber : Int?
        let purpose : String?
        let rating : String?
        let reminder : String?
        let reminderinString : String?
        let time : String?
        let timeInString : String?
        let userId : String?
        let visitStatus : String?

        enum CodingKeys: String, CodingKey {
                case v = "__v"
                case id = "_id"
                case addedDate = "addedDate"
                case address = "address"
                case businessName = "businessName"
                case contactId = "contactId"
                case contactName = "contactName"
                case contactType = "contactType"
                case contractId = "contractId"
                case contractNumber = "contractNumber"
                case dateInString = "dateInString"
                case email = "email"
                case lat = "lat"
                case longField = "long"
                case phoneNumber = "phoneNumber"
                case purpose = "purpose"
                case rating = "rating"
                case reminder = "reminder"
                case reminderinString = "reminderinString"
                case time = "time"
                case timeInString = "timeInString"
                case userId = "userId"
                case visitStatus = "visitStatus"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                v = try values.decodeIfPresent(Int.self, forKey: .v)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                addedDate = try values.decodeIfPresent(String.self, forKey: .addedDate)
                address = try values.decodeIfPresent(String.self, forKey: .address)
                businessName = try values.decodeIfPresent(String.self, forKey: .businessName)
                contactId = try values.decodeIfPresent(String.self, forKey: .contactId)
                contactName = try values.decodeIfPresent(String.self, forKey: .contactName)
                contactType = try values.decodeIfPresent(String.self, forKey: .contactType)
                contractId = try values.decodeIfPresent(String.self, forKey: .contractId)
                contractNumber = try values.decodeIfPresent(String.self, forKey: .contractNumber)
                dateInString = try values.decodeIfPresent(String.self, forKey: .dateInString)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                lat = try values.decodeIfPresent(String.self, forKey: .lat)
                longField = try values.decodeIfPresent(String.self, forKey: .longField)
                phoneNumber = try values.decodeIfPresent(Int.self, forKey: .phoneNumber)
                purpose = try values.decodeIfPresent(String.self, forKey: .purpose)
                rating = try values.decodeIfPresent(String.self, forKey: .rating)
                reminder = try values.decodeIfPresent(String.self, forKey: .reminder)
                reminderinString = try values.decodeIfPresent(String.self, forKey: .reminderinString)
                time = try values.decodeIfPresent(String.self, forKey: .time)
                timeInString = try values.decodeIfPresent(String.self, forKey: .timeInString)
                userId = try values.decodeIfPresent(String.self, forKey: .userId)
                visitStatus = try values.decodeIfPresent(String.self, forKey: .visitStatus)
        }

}
