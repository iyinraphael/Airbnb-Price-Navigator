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
    var roomType: String?
    var accommodates: Int
    var bathrooms: Int
    var bedrooms: Int
    var beds: Int
    var bedType: String?
}



struct Prediction: Codable {
    let bins: [Int]
    let plotValues: [Int]
    let prediction: Int
}





