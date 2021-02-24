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
    private var servers = [Server]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationsBarItems("Servers list")
        configureTableView()
        
        loadServerData() //Тест
    }
    
    //Для тестов
    private func loadServerData() {
        for token in tokens {
            DataManager.shared.getServerStatusData(by: token) { [weak self] data in
                guard let data = data else { return }
                guard let self = self else { return }
                
                self.servers.append(data)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "Background")
        
        tableView.register(ServersListTableViewCell.nib, forCellReuseIdentifier: ServersListTableViewCell.nibName)
    }
    
    // MARK: - Navigations Bar
    private func configureNavigationsBarItems(_ title: String) {
        guard let navController = navigationController else { return }
        
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
        
        navigationItem.title = title
        
        navigationItem.rightBarButtonItems = [
            .init(barButtonSystemItem: .add, target: self, action: #selector(addServerBarButtonTapped))
        ]
        
//        navigationItem.leftBarButtonItem = .init(title: "Log In", style: .plain, target: self, action: #selector(handleLogin))
    }
    
    @objc private func addServerBarButtonTapped() {
        let controller = AddServerViewController()
        controller.completionHandler = { token in
            print("* Token = \(token)")
        }
        
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
        return servers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServersListTableViewCell.nibName, for: indexPath) as! ServersListTableViewCell
        
        print(servers[indexPath.row])
        cell.configure(with: servers[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let server = servers[indexPath.row]
        let viewControllers = [
            ServerInfoViewController(),
            SecondViewController()
        ]
        
        viewControllers[0].title = "Info"
        viewControllers[1].title = "Red"
        
        //https://www.youtube.com/watch?v=6CEWHlM8Ecw
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(viewControllers, animated: true)
        
//        self.navigationItem.largeTitleDisplayMode = .never
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.pushViewController(tabBarController, animated: true)
    }
}

class SecondViewController: UIViewController {
    
    deinit { print("* deinit -> SecondViewController") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}
