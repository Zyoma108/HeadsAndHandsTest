//
//  UITextFieldExtension+FloatingPlaceholder.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 18/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import UIKit

extension UITextField {
    
    private static let placholderTag = 10
    
    func addFloatingPlaceholderWith(font: UIFont, color: UIColor) {
        addTarget(self, action: #selector(textChanged), for: .editingChanged)
        
        let label = placeHolderLabel()
        label.text = placeholder
        label.font = font
        label.textColor = color
        label.textAlignment = .left
        label.alpha = 0
        label.tag = UITextField.placholderTag
    }
    
    @objc private func textChanged() {
        guard let placeholderLabel = subviews.first(where: { $0.tag == UITextField.placholderTag }) as? UILabel else { return }
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            placeholderLabel.alpha = (self?.text ?? "").isEmpty ? 0 : 1
        }
    }
    
    private func placeHolderLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: topAnchor, constant: 3)
        ])
    
        return label
    }
}

