//
//  Propetry.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

struct Property: Codable {
    var zipcode: String
    var propertyType: String
    var roomType: RoomType?
    var accommodates: Int
    var bathrooms: Int
    var bedrooms: Int
    var beds: Int
    var bedType: BedType?
    
    enum RoomType: String, Codable {
            case entireProperty = "Entire home/apt"
            case privateRoom = "Private Room"
            case sharedRoom = "Shared Room"
    }
    
    enum BedType: String, Codable {
       case standardBed = "Real Bed"
       case couch = "Couch"
       case futon = "Futon"
       case pullOutCouch = "Pull-Out Sofa"
       case airMattress = "Airbed"
   }
}



struct Prediction: Codable {
    let bins: [Int]
    let plotValues: [Int]
    let prediction: Int
}





