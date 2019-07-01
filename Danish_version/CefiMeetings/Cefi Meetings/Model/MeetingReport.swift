//
//  MeetingReport.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 14, 2019

import Foundation

struct MeetingReport : Codable {

        let v : Int?
        let id : String?
        let addedDate : String?
        let commentOnSales : String?
        let contractError : Bool?
        let deadCancel : Bool?
        let dealerPersonName : String?
        let didNotAgreetoTerms : Bool?
        let duration : String?
        let equipmentNeeds : String?
        let followUpVisitId : String?
        let followUpVisitTime : String?
        let leadsAvailable : String?
        let mainOutcome : String?
        let other : Bool?
        let otherComments : String?
        let outcomeComments : String?
        let reportStatus : String?
        let reportType : String?
        let salesInLastThreeMonths : String?
        let userId : String?
        let visitId : String?

        enum CodingKeys: String, CodingKey {
                case v = "__v"
                case id = "_id"
                case addedDate = "addedDate"
                case commentOnSales = "commentOnSales"
                case contractError = "contractError"
                case deadCancel = "deadCancel"
                case dealerPersonName = "dealerPersonName"
                case didNotAgreetoTerms = "didNotAgreetoTerms"
                case duration = "duration"
                case equipmentNeeds = "equipmentNeeds"
                case followUpVisitId = "followUpVisitId"
                case followUpVisitTime = "followUpVisitTime"
                case leadsAvailable = "leadsAvailable"
                case mainOutcome = "mainOutcome"
                case other = "other"
                case otherComments = "otherComments"
                case outcomeComments = "outcomeComments"
                case reportStatus = "reportStatus"
                case reportType = "reportType"
                case salesInLastThreeMonths = "salesInLastThreeMonths"
                case userId = "userId"
                case visitId = "visitId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                v = try values.decodeIfPresent(Int.self, forKey: .v)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                addedDate = try values.decodeIfPresent(String.self, forKey: .addedDate)
                commentOnSales = try values.decodeIfPresent(String.self, forKey: .commentOnSales)
                contractError = try values.decodeIfPresent(Bool.self, forKey: .contractError)
                deadCancel = try values.decodeIfPresent(Bool.self, forKey: .deadCancel)
                dealerPersonName = try values.decodeIfPresent(String.self, forKey: .dealerPersonName)
                didNotAgreetoTerms = try values.decodeIfPresent(Bool.self, forKey: .didNotAgreetoTerms)
                duration = try values.decodeIfPresent(String.self, forKey: .duration)
                equipmentNeeds = try values.decodeIfPresent(String.self, forKey: .equipmentNeeds)
                followUpVisitId = try values.decodeIfPresent(String.self, forKey: .followUpVisitId)
                followUpVisitTime = try values.decodeIfPresent(String.self, forKey: .followUpVisitTime)
                leadsAvailable = try values.decodeIfPresent(String.self, forKey: .leadsAvailable)
                mainOutcome = try values.decodeIfPresent(String.self, forKey: .mainOutcome)
                other = try values.decodeIfPresent(Bool.self, forKey: .other)
                otherComments = try values.decodeIfPresent(String.self, forKey: .otherComments)
                outcomeComments = try values.decodeIfPresent(String.self, forKey: .outcomeComments)
                reportStatus = try values.decodeIfPresent(String.self, forKey: .reportStatus)
                reportType = try values.decodeIfPresent(String.self, forKey: .reportType)
                salesInLastThreeMonths = try values.decodeIfPresent(String.self, forKey: .salesInLastThreeMonths)
                userId = try values.decodeIfPresent(String.self, forKey: .userId)
                visitId = try values.decodeIfPresent(String.self, forKey: .visitId)
        }

}
