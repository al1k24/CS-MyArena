//
//  ServerInfoViewController.swift
//  CS-MyArena
//
//  Created by Алик on 21.02.2021.
//

import UIKit

class ServerInfoViewController: UIViewController {
    
    deinit { print("* deinit -> ServerInfoViewController") }
    
//    lazy var server: Server

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.title = "ServerInfo"
        
//        view.backgroundColor = .green
//        self.navigationItem.title = "Server ID #\(serverId)"
//        self.navigationItem.largeTitleDisplayMode = .never
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
    }
}
