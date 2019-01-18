//
//  ViewController.swift
//  HeadsAndHandsTest
//
//  Created by Roman Sentsov on 16/01/2019.
//  Copyright © 2019 Roman Sentsov. All rights reserved.
//

import UIKit

class InitialViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet private weak var testButton: UIButton!
    
    let viewModel = InitialViewModel()
    
    // MARK: - Actions
    @IBAction private func testButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: viewModel.loginSegueIdentifier, sender: nil)
    }
    
}
