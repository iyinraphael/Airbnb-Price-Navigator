//
//  PropertyViewModel.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 3/10/21.
//  Copyright © 2021 Iyin Raphael. All rights reserved.
//

import Foundation

class PropertyViewModel {
    
    // MARK: - Properties
    let zipcode = Box(value: " ")
    let propertyType = Box(value: " ")
    let roomType = Box(value: " ")
    let accomodates = Box(value: " ")
    let bathrooms = Box(value: " ")
    let bedrooms = Box(value: " ")
    let beds = Box(value: " ")
    let bedType = Box(value: " ")
    let prediction: Box<PricePredict?> = Box(value: nil)

    let network = Network()
    
    // MARK: - Methods
    func displayPropertyPrice() {
        guard let accomodateInt = Int(accomodates.value),
              let bathroomInt = Int(bathrooms.value),
              let bedroomInt = Int(bedrooms.value),
              let bedInt = Int(beds.value) else { return }
        
        let property = Property(zipcode: zipcode.value,
                                propertyType: propertyType.value,
                                roomType: roomType.value,
                                accommodates: accomodateInt,
                                bathrooms: bathroomInt,
                                bedrooms: bedInt,
                                beds: bedroomInt,
                                bedType: bedType.value)
        
        network.postPropeties(property: property) { prediction, _ in
            self.prediction.value = prediction
        }
    }
    
}
