//
//  UIViewExtensions+Radius.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 17/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            if !layer.masksToBounds {
                layer.masksToBounds = true
            }
        }
        get {
            return layer.cornerRadius
        }
    }
}
