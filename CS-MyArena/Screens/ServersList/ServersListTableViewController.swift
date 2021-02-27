//
//  ServersListTableViewController.swift
//  CS-MyArena
//
//  Created by Алик on 18.02.2021.
//

import UIKit
import SPAlert
import SPStorkController

class ServersListTableViewController: UITableViewController {
    
    deinit { print("* deinit -> ServersListTableViewController") }
    
    private var tokens = [ //Для теста пока так
        "9995a3c768b8a71c33023fe2b2ef393e"
    ]
    
//    private var ggtokens: [Strong: Server] ////Вот так сделать
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupTableView()
    }
    
    // MARK: - Table view
    private func setupTableView() {
        tableView.rowHeight = 128
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "Background")
        
        tableView.register(ServersListTableViewCell.nib, forCellReuseIdentifier: ServersListTableViewCell.nibName)
    }
    
    // MARK: - Navigations Bar
    private func setupNavigationController() {
        guard let navController = self.navigationController else { return }
        
        let navBarAppearance: UINavigationBarAppearance = {
            let nba = UINavigationBarAppearance()
            nba.configureWithOpaqueBackground()
            nba.titleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "Metropolis-SemiBold", size: 18) ?? .systemFont(ofSize: 18)
            ]
            nba.largeTitleTextAttributes = [
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "Metropolis-Bold", size: 34) ?? .systemFont(ofSize: 18)
            ]
            nba.shadowColor = .clear
            nba.backgroundColor = UIColor(named: "Background")
            return nba
        }()
        
        navController.navigationBar.standardAppearance = navBarAppearance
        navController.navigationBar.compactAppearance = navBarAppearance
        navController.navigationBar.scrollEdgeAppearance = navBarAppearance

        navController.navigationBar.tintColor = UIColor(named: "White")
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.prefersLargeTitles = true
//        navController.navigationBar.overrideUserInterfaceStyle = .dark
        
        navigationItem.title = "Servers list"
        
        navigationItem.rightBarButtonItems = [
            .init(barButtonSystemItem: .add, target: self, action: #selector(addServerBarButtonTapped))
        ]
    }
    
    @objc private func addServerBarButtonTapped() {
        let controller = AddServerViewController()
        controller.delegate = self
        
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.customHeight = 568 //268
        transitionDelegate.showIndicator = true
        
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        controller.view.backgroundColor = UIColor(named: "Background")

        self.present(controller, animated: true, completion: nil)
        
//        let alertView = SPAlertView(title: "Complete", preset: .done)
//        alertView.present(duration: 3)
//        SPAlert.present(title: "Love", message: "We'll recommend more like this in For You", preset: .custom(UIImage.init(named: "heart")!))
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tokens.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServersListTableViewCell.nibName, for: indexPath) as! ServersListTableViewCell
        
//        print(servers[indexPath.row])
        DataManager.shared.getServerStatusData(by: tokens[indexPath.row]) { data in
            guard let data = data else { return }
//            guard let self = self else { return }

//            self.servers.append(data)
            cell.configure(with: data)
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabBarController = ServerInfoTabBarController()
        navigationController?.pushViewController(tabBarController, animated: true)
    }
}

extension ServersListTableViewController: AddServerViewControllerDelegate {
    func addServerViewController(_ vc: AddServerViewController, didAddToken token: String) {
        print("*[ServersListTableViewController] token = \(token)")
    }
}
