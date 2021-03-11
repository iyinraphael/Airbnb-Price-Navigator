//
//  PropertryController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

class Network {
    
    // MARK: - Properties
    
    private let baseUrl = URL(string: "https://airbnbpricepredictor.tk/prediction")!
    typealias completionHandler = (Prediction?,Error?) -> Void
    var prediction: Prediction?

    // MARK: - Methods
    
    func postPropeties(property: Property, completion: @escaping completionHandler ) {
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"
        
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
            request.httpBody = try jsonEncoder.encode(property)
        } catch {
            NSLog("Error encoding httpbody")
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error occured while trying post data \(error)")
                return
            }
            guard let data = data else {return}
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodeJson = try decoder.decode(Prediction.self, from: data)
                print("\(decodeJson)")
                completion(decodeJson, nil)
            } catch {
                NSLog("Error getting prediction \(error)")
               completion(nil, error)
            }
            
        }.resume()
    }
    
}
