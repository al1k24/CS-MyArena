//
//  ServerInfoViewController.swift
//  CS-MyArena
//
//  Created by Алик on 21.02.2021.
//

import UIKit

class ServerInfoViewController: UIViewController {
    
    deinit { print("* deinit -> ServerInfoViewController") }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Table view
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 460
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "Background")
        
        tableView.register(ServerInfoTableViewCell.nib, forCellReuseIdentifier: ServerInfoTableViewCell.nibName)
    }
}

extension ServerInfoViewController: UITableViewDelegate {
    
}

extension ServerInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServerInfoTableViewCell.nibName, for: indexPath) as! ServerInfoTableViewCell
        
//        print(servers[indexPath.row])
//        DataManager.shared.getServerStatusData(by: tokens[indexPath.row]) { data in
//            guard let data = data else { return }
////            guard let self = self else { return }
//
////            self.servers.append(data)
//            cell.configure(with: data)
//        }
    
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ServerInfoTableViewCell.nibName, for: indexPath) as! ServerInfoTableViewCell
//        return cell.heightAnchor
//    }
    
}
