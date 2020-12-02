//
//  PropertryController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

class PropertyController {
    
    let baseUrl = URL(string: "https://airbnbpricepredictor.tk/prediction")!
    typealias completionHandler = (Prediction?,Error?) -> Void
    var prediction: Prediction?

    
}
