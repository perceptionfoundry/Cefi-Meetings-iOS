//
//  Dealer.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on March 18, 2019

import Foundation

struct Dealer : Codable {

        let v : Int?
        let id : String?
        let dealerId : String?
        let personName : String?
        let userId : String?

        enum CodingKeys: String, CodingKey {
                case v = "__v"
                case id = "_id"
                case dealerId = "dealerId"
                case personName = "personName"
                case userId = "userId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                v = try values.decodeIfPresent(Int.self, forKey: .v)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                dealerId = try values.decodeIfPresent(String.self, forKey: .dealerId)
                personName = try values.decodeIfPresent(String.self, forKey: .personName)
                userId = try values.decodeIfPresent(String.self, forKey: .userId)
        }

}
