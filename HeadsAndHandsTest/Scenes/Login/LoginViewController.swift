//
//  LoginViewController.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 17/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var visibleViewBottom: NSLayoutConstraint!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    let viewModel = LoginViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeForKeyboardEvents()
    }
    
    // MARK: - Keyboard
    override func keyboardWillAppearWithHeight(_ keyboardHeight: CGFloat) {
        setVisibleViewBottomWith(height: keyboardHeight)
    }
    
    override func keyboardWillDisappear() {
        setVisibleViewBottomWith(height: 0)
    }
    
    // MARK: - Actions
    @IBAction private func loginButtonClicked(_ sender: Any) {
        viewModel.login()
    }
    
    @IBAction private func signUpButtonClicked(_ sender: Any) {
        
    }

    @IBAction private func textDidChange(_ sender: UITextField) {
        switch sender {
        case emailTextField:
            viewModel.email = sender.text
        case passwordTextField:
            viewModel.password = sender.text
        default:
            break
        }
    }
    
    @objc private func tapOnBackground() {
        view.endEditing(false)
    }
    
    // MARK: - Private
    private func setup() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnBackground)))
        
        loginButton.cornerRadius = loginButton.frame.height / 2
        [emailTextField, passwordTextField].forEach { textField in
            textField?.delegate = self
            textField?.addUnderLineWith(color: .whiteThree)
            textField?.addFloatingPlaceholderWith(font: UIFont.systemFont(ofSize: 12), color: .warmGrey)
        }
        
        viewModel.errorSubject.subscribe(onNext: { [weak self] message in
            guard let `self` = self else { return }
            
            self.showAlertWith(title: "Ошибка", message: message)
        }).disposed(by: disposeBag)
    }
    
    private func setVisibleViewBottomWith(height: CGFloat) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.visibleViewBottom.constant = height
            self?.view.layoutIfNeeded()
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.endEditing(false)
        default:
            break
        }
        
        return true
    }
    
}
