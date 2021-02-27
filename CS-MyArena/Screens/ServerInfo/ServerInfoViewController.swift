//
//  ServerInfoViewController.swift
//  CS-MyArena
//
//  Created by Алик on 21.02.2021.
//

import UIKit

class ServerInfoViewController: UIViewController {
    
    deinit { print("* deinit -> ServerInfoViewController") }
    
    @IBOutlet weak var mapImage: UIImageView!
    
    private var token: String?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let darkBlur = UIBlurEffect(style: .regular)
        // 2
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = mapImage.bounds
        blurView.alpha = 0.7
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurView.frame = mapImage.bounds
        // 3
        mapImage.addSubview(blurView)
        
//        print("-> ServerInfoViewController -> \(token!)")
    }
}
