//
//  NetworkController.swift
//  Airbnb-Price-Navigator
//
//  Created by Iyin Raphael on 9/14/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

extension PropertyController {
    
    
    func postPropeties(property: Property, completion: @escaping completionHandler ) {
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "POST"
        
        do {
            let jsonEncoder = JSONEncoder()
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
            do {
                let decodeJson = try decoder.decode(Prediction.self, from: data)
                completion(decodeJson, nil)
            } catch {
                NSLog("Error getting prediction \(error)")
               completion(nil, error)
            }
            
        }.resume()
    }
    
}
