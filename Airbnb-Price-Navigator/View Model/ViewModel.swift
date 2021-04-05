//
//  ViewModel.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 4/5/21.
//  Copyright © 2021 Iyin Raphael. All rights reserved.
//

import Foundation

class ViewModel {
    
    // MARK: - Property
    private let network = Network()
    var didFinish: (()-> ())?
    var price: PricePredict? {
        didSet {
            self.didFinish?()
        }
    }
    
    
    
    func predictPrice(property: Property) {
        network.postPropeties(property: property) { price, _ in
            if let price = price {
                self.price = price
                
            }
        }
    }
}
