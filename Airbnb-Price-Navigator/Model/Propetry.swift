//
//  Propetry.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

struct Property: Codable {
    var zipCode: String
    var propertyType: String
    var roomType: String?
    var accomodates: Int
    var bathrooms: Int
    var bedrooms: Int
    var beds: Int
    var bedType: String?
    
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "zipcode"
        case propertyType = "property_type"
        case roomType = "room_type"
        case accomodates = "accommodates"
        case bathrooms = "bathrooms"
        case bedrooms = "bedrooms"
        case beds = "beds"
        case bedType = "bed_type"
    }
}



struct Prediction: Codable {
    let bins: [Int]
    let plotValues: [Int]
    let prediction: Int
    
    enum CodingKeys: String, CodingKey {
        case bins = "bins"
        case plotValues = "plot_values"
        case prediction = "prediction"
        
    }
}





