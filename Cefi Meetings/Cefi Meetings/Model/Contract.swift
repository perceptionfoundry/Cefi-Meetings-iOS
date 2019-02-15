//
//  Contract.swift
//  Cefi Meetings
//
//  Created by Syed ShahRukh Haider on 14/02/2019.
//  Copyright © 2019 Syed ShahRukh Haider. All rights reserved.
//

import Foundation


struct Contract : Decodable{
    
   
    var equipmentDetails : [String]
    var isTaxReturnsAvailable : String
    var taxReturnImages : [String]
    var isBankStatementAvailable : Bool
    var bankStatements : [String]
    var isEquipmentImagesAvailable : Bool
    var equipmentImages : [String]
    var isInsuranceAvailable : Bool
    var insuranceCertificate : Bool
    var isSignorAvailable : Bool
    var signorAndSecretaryId : Bool
    var isInvoiceAvailable : Bool
    var invoice : String
    var isClosingFees : Bool
    var closingFees : String
    var isAllPagesSigned : Bool
    var allPagesSignedImage : String
    var isEverythingCompleted : Bool
    var everyThingCompleted : String
    var missingText : String
    var allPendingDocumentCounts : Double
    var _id : String
    var userId : String
    var addedDate : String
    var contactId : String
    var contractStatus : String
    var projectedPurchaseDate : String
    var equipmentCost : String
    var rating : String
    var contractNumber : String
    var __v : Double
   


}
