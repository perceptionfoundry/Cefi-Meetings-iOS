//
//  Contract.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on May 3, 2019

import Foundation

struct Contract : Codable {

        let v : Int?
        let id : String?
        let addedDate : String?
        let allPagesSignedImage : [String]?
        let allPendingDocumentCounts : Int?
        let bankStatements : [String]?
        let closingFees : [String]?
        let contactId : String?
        let contactName : String?
        let contractNumber : String?
        let contractStatus : String?
        let contractStatusUpdated : String?
        let equipmentCost : Float?
        let equipmentDetails : [String]?
        let equipmentImages : [String]?
        let everyThingCompleted : [String]?
        let insuranceCertificate : [String]?
        let invoice : [String]?
        let isAllPagesSigned : Bool?
        let isBankStatementAvailable : Bool?
        let isClosingFees : Bool?
        let isEquipmentImagesAvailable : Bool?
        let isEverythingCompleted : Bool?
        let isInsuranceAvailable : Bool?
        let isInvoiceAvailable : Bool?
        let isSignorAvailable : Bool?
        let isTaxReturnsAvailable : Bool?
        let missingText : String?
        let projectedPurchaseDate : Int?
        let rating : String?
        let signorAndSecretaryId : [String]?
        let taxReturnImages : [String]?
        let userId : String?
        let visitId : String?

        enum CodingKeys: String, CodingKey {
                case v = "__v"
                case id = "_id"
                case addedDate = "addedDate"
                case allPagesSignedImage = "allPagesSignedImage"
                case allPendingDocumentCounts = "allPendingDocumentCounts"
                case bankStatements = "bankStatements"
                case closingFees = "closingFees"
                case contactId = "contactId"
                case contactName = "contactName"
                case contractNumber = "contractNumber"
                case contractStatus = "contractStatus"
                case contractStatusUpdated = "contractStatusUpdated"
                case equipmentCost = "equipmentCost"
                case equipmentDetails = "equipmentDetails"
                case equipmentImages = "equipmentImages"
                case everyThingCompleted = "everyThingCompleted"
                case insuranceCertificate = "insuranceCertificate"
                case invoice = "invoice"
                case isAllPagesSigned = "isAllPagesSigned"
                case isBankStatementAvailable = "isBankStatementAvailable"
                case isClosingFees = "isClosingFees"
                case isEquipmentImagesAvailable = "isEquipmentImagesAvailable"
                case isEverythingCompleted = "isEverythingCompleted"
                case isInsuranceAvailable = "isInsuranceAvailable"
                case isInvoiceAvailable = "isInvoiceAvailable"
                case isSignorAvailable = "isSignorAvailable"
                case isTaxReturnsAvailable = "isTaxReturnsAvailable"
                case missingText = "missingText"
                case projectedPurchaseDate = "projectedPurchaseDate"
                case rating = "rating"
                case signorAndSecretaryId = "signorAndSecretaryId"
                case taxReturnImages = "taxReturnImages"
                case userId = "userId"
                case visitId = "visitId"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                v = try values.decodeIfPresent(Int.self, forKey: .v)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                addedDate = try values.decodeIfPresent(String.self, forKey: .addedDate)
                allPagesSignedImage = try values.decodeIfPresent([String].self, forKey: .allPagesSignedImage)
                allPendingDocumentCounts = try values.decodeIfPresent(Int.self, forKey: .allPendingDocumentCounts)
                bankStatements = try values.decodeIfPresent([String].self, forKey: .bankStatements)
                closingFees = try values.decodeIfPresent([String].self, forKey: .closingFees)
                contactId = try values.decodeIfPresent(String.self, forKey: .contactId)
                contactName = try values.decodeIfPresent(String.self, forKey: .contactName)
                contractNumber = try values.decodeIfPresent(String.self, forKey: .contractNumber)
                contractStatus = try values.decodeIfPresent(String.self, forKey: .contractStatus)
                contractStatusUpdated = try values.decodeIfPresent(String.self, forKey: .contractStatusUpdated)
                equipmentCost = try values.decodeIfPresent(Float.self, forKey: .equipmentCost)
                equipmentDetails = try values.decodeIfPresent([String].self, forKey: .equipmentDetails)
                equipmentImages = try values.decodeIfPresent([String].self, forKey: .equipmentImages)
                everyThingCompleted = try values.decodeIfPresent([String].self, forKey: .everyThingCompleted)
                insuranceCertificate = try values.decodeIfPresent([String].self, forKey: .insuranceCertificate)
                invoice = try values.decodeIfPresent([String].self, forKey: .invoice)
                isAllPagesSigned = try values.decodeIfPresent(Bool.self, forKey: .isAllPagesSigned)
                isBankStatementAvailable = try values.decodeIfPresent(Bool.self, forKey: .isBankStatementAvailable)
                isClosingFees = try values.decodeIfPresent(Bool.self, forKey: .isClosingFees)
                isEquipmentImagesAvailable = try values.decodeIfPresent(Bool.self, forKey: .isEquipmentImagesAvailable)
                isEverythingCompleted = try values.decodeIfPresent(Bool.self, forKey: .isEverythingCompleted)
                isInsuranceAvailable = try values.decodeIfPresent(Bool.self, forKey: .isInsuranceAvailable)
                isInvoiceAvailable = try values.decodeIfPresent(Bool.self, forKey: .isInvoiceAvailable)
                isSignorAvailable = try values.decodeIfPresent(Bool.self, forKey: .isSignorAvailable)
                isTaxReturnsAvailable = try values.decodeIfPresent(Bool.self, forKey: .isTaxReturnsAvailable)
                missingText = try values.decodeIfPresent(String.self, forKey: .missingText)
                projectedPurchaseDate = try values.decodeIfPresent(Int.self, forKey: .projectedPurchaseDate)
                rating = try values.decodeIfPresent(String.self, forKey: .rating)
                signorAndSecretaryId = try values.decodeIfPresent([String].self, forKey: .signorAndSecretaryId)
                taxReturnImages = try values.decodeIfPresent([String].self, forKey: .taxReturnImages)
                userId = try values.decodeIfPresent(String.self, forKey: .userId)
                visitId = try values.decodeIfPresent(String.self, forKey: .visitId)
        }

}
