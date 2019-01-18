//
//  CustomButtonView.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 18/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButtonView: UIControl {
    
    private struct Constants {
        static let titleOffset: CGFloat = 10
    }

    // MARK: - Properties
    @IBInspectable
    var title: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var titleFontSize: CGFloat = 12 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var titleColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.titleOffset),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.titleOffset)
        ])

        return label
    }()
    
    // MARK: - Life Cycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        update()
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Private
    private func setup() {
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
        addTarget(self, action: #selector(touchUp), for: .touchCancel)
    }
    
    private func update() {
        titleLabel.text = title
        titleLabel.textColor = titleColor
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    // MARK: - Actions
    @objc private func touchDown() {
        titleLabel.textColor = titleColor.withAlphaComponent(0.4)
    }
    
    @objc private func touchUp() {
        titleLabel.textColor = titleColor
    }

}
