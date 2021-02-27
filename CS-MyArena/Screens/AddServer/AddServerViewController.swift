//
//  AddServerViewController.swift
//  CS-MyArena
//
//  Created by Алик on 21.02.2021.
//

import UIKit

protocol AddServerViewControllerDelegate: class {
    func addServerViewController(_ vc: AddServerViewController, didAddToken token: String)
}

class AddServerViewController: UIViewController {
    
    deinit { print("* deinit -> AddServerViewController") }
    
    @IBOutlet private weak var tokenField: UITextField!
    @IBOutlet private weak var addServerButton: UIButton!
    
    weak var delegate: AddServerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
    }
    
    private func setupButton() {
        addServerButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        if let token = self.tokenField.text {
            delegate?.addServerViewController(self, didAddToken: token)
        }
        
        self.dismiss(animated: true)
    }
}
