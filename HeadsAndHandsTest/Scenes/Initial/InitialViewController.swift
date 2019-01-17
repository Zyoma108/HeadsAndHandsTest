//
//  ViewController.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 16/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var testButton: UIButton!
    
    let viewModel = InitialViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Actions
    @IBAction private func testButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: viewModel.loginSegueIdentifier, sender: nil)
    }
    
    // MARK: - Private
    private func setup() {
        testButton.cornerRadius = testButton.frame.height / 2
    }
    
}
