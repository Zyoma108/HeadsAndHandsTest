//
//  BaseViewController.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 17/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unsubscribeForKeyboardEvents()
    }

    // MARK: - Keyboard
    func unsubscribeForKeyboardEvents() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func subscribeForKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            keyboardWillAppearWithHeight(keyboardHeight)
        }
    }
    
    @objc func keyboardWillDisappear() { }
    
    func keyboardWillAppearWithHeight(_ keyboardHeight: CGFloat) { }
    
}
