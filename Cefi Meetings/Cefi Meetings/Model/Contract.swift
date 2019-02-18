//
//  Contract.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 14/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation


class Contract : Decodable{
    
   
    var equipmentDetails : [String]
    var isTaxReturnsAvailable : Bool
    var taxReturnImages : [String]?
    var isBankStatementAvailable : Bool
    var bankStatements : [String]?
    var isEquipmentImagesAvailable : Bool
    var equipmentImages : [String]?
    var isInsuranceAvailable : Bool
    var insuranceCertificate : Bool?
    var isSignorAvailable : Bool
    var signorAndSecretaryId : Bool?
    var isInvoiceAvailable : Bool
    var invoice : String?
    var isClosingFees : Bool
    var closingFees : String?
    var isAllPagesSigned : Bool
    var allPagesSignedImage : String?
    var isEverythingCompleted : Bool
    var everyThingCompleted : String?
    var missingText : String
    var allPendingDocumentCounts : Double?
    var _id : String?
    var userId : String
    var addedDate : String?
    var contactId : String
    var contractStatus : String
    var projectedPurchaseDate : String
    var equipmentCost : String
    var rating : String
    var contractNumber : String?
    var __v : Double?
   

    init (dicValue : [String:Any]){
        
        userId = dicValue["userId"] as! String
        contactId = dicValue["contactId"] as! String
        contractStatus = dicValue["contractStatus"] as! String
        projectedPurchaseDate = dicValue["projectPurchased"] as! String
        equipmentCost = dicValue["equipmentCost"] as! String
        equipmentDetails = dicValue["equipmentDetail"] as! [String]
        rating = dicValue["rating"] as! String
        isTaxReturnsAvailable = dicValue["isTax"] as! Bool
        isBankStatementAvailable = dicValue["isBank"] as! Bool
        isEquipmentImagesAvailable = dicValue["isEquipment"] as! Bool
        isInsuranceAvailable = dicValue["isInsurance"] as! Bool
        isSignorAvailable = dicValue["isSignor"] as! Bool
        isInvoiceAvailable = dicValue["inVoice"] as! Bool
        isClosingFees = dicValue["isClosing"] as! Bool
        isAllPagesSigned  = dicValue["isAllPages"] as! Bool
        isEverythingCompleted = dicValue["isEverything"] as! Bool
        everyThingCompleted = dicValue["everything"] as! String
        missingText = dicValue["missingText"] as! String
        
    }

}
