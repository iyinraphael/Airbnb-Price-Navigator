//
//  Box.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 3/11/21.
//  Copyright © 2021 Iyin Raphael. All rights reserved.
//

import Foundation

final class Box<T> {
    
    // MARK: - Property
    typealias Listner = (T) -> Void
    var listner: Listner?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }

    init(value: T) {
        self.value = value
    }
    
    // MARK: - Method
    func bind(listner: Listner?) {
        self.listner = listner
        listner?(value)
    }
}
