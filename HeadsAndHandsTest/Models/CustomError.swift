//
//  CustomError.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 18/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import Foundation

struct CustomError: LocalizedError {
    
    private let description: String
    
    var errorDescription: String? { return description }
    var failureReason: String? { return description }
    
    init(description: String) {
        self.description = description
    }
}
