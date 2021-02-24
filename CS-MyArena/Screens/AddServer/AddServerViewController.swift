//
//  AddServerViewController.swift
//  CS-MyArena
//
//  Created by Алик on 21.02.2021.
//

import UIKit

class AddServerViewController: UIViewController {
    
    deinit { print("* deinit -> AddServerViewController") }
    
    @IBOutlet private weak var tokenField: UITextField!
    @IBOutlet private weak var addServerButton: UIButton!
    
    var completionHandler: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
    }
    
    private func configureButton() {
        addServerButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        if let token = self.tokenField.text {
            completionHandler?(token)
        }
        
        self.dismiss(animated: true)
    }
}
