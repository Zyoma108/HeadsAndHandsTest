//
//  WeatherService.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 18/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import Foundation
import Alamofire

class WeatherService: APIService {
    
    typealias T = Weather
    
    var url: String { return "https://api.apixu.com/v1/current.json" }
    var method: HTTPMethod { return .get }
    var parameters: [String : Any] {
        return [
            "key": Constants.apixApiKey,
            "q": city
        ]
    }
    
    let city: String
    
    init(city: String) {
        self.city = city
    }
}
