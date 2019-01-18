//
//  Weather.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 18/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    let tempC: Float
    let windKph: Float
    let windDir: String
    let condition: String
    
    //custom decoder
    enum CodingKeys: String, CodingKey {
        case current
    }
    
    enum CurrentCodingKeys: String, CodingKey {
        case temp_c
        case wind_kph
        case wind_dir
        case condition
    }
    
    enum ConditionCcodingKeys: String, CodingKey {
        case text
    }
    
    init(from decoder: Decoder) throws {
        let root = try decoder.container(keyedBy: CodingKeys.self)
        let current = try root.nestedContainer(keyedBy: CurrentCodingKeys.self, forKey: .current)
        
        tempC = try current.decode(Float.self, forKey: .temp_c)
        windKph = try current.decode(Float.self, forKey: .wind_kph)
        windDir = try current.decode(String.self, forKey: .wind_dir)
        
        let condition = try current.nestedContainer(keyedBy: ConditionCcodingKeys.self, forKey: .condition)
        self.condition = try condition.decode(String.self, forKey: .text)
    }
}
