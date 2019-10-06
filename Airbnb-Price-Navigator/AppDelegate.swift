//
//  AppDelegate.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let propertyController = PropertyController()
  
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let property  = Property(zipCode: "90210", propertyType: "Villa", roomType: "Private room", accomodates: 5, bathrooms: 12, bedrooms: 2, beds: 2, bedType: "Real Bed")
        propertyController.postPropeties(property: property) { (preidction, error) in
            print("\(preidction!)")
        }
    
        return true
    }

}

