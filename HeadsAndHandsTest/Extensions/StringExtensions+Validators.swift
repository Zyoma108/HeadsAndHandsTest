//
//  StringExtensions+Validators.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 18/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let regexp = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regexp).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regexp = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", regexp).evaluate(with: self)
    }
    
}
