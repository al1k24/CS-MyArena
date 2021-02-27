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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationsBarItems("Servers list")
        configureTableView()
    }
    
    weak var delegate: ServerListDelegate?
    
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
//            print(data)
//                tableView.reloadData()
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let serverInfoVC: UIViewController = {
            let vc = ServerInfoViewController()
            vc.tabBarItem = UITabBarItem(title: "Info",
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
            return vc
        }()
        
        let viewControllers = [
            serverInfoVC,
            ServerPlayersViewController(),
            ServerMapsTableViewController(),
            ServerConsoleViewController()
        ]
        
        viewControllers[1].tabBarItem = UITabBarItem(title: "Players",
                                                     image: UIImage(systemName: "person.2"),
                                                     selectedImage: UIImage(systemName: "person.2.fill"))
        viewControllers[2].tabBarItem = UITabBarItem(title: "Maps",
                                                     image: UIImage(systemName: "map"),
                                                     selectedImage: UIImage(systemName: "map.fill"))
        viewControllers[3].tabBarItem = UITabBarItem(title: "Console",
                                                     image: UIImage(systemName: "text.bubble"),
                                                     selectedImage: UIImage(systemName: "text.bubble.fill"))
        
        //https://www.youtube.com/watch?v=6CEWHlM8Ecw
        let tabBarController = TestTabBarVC()
        self.delegate = tabBarController
//        tabBarController.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0)}
        tabBarController.setViewControllers(viewControllers, animated: true)
        
        let appearance = UITabBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(named: "Background")
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        
        tabBarController.tabBar.standardAppearance = appearance
        
        navigationController?.pushViewController(tabBarController, animated: true)
        
        delegate?.onServerTapped(with: tokens[indexPath.row])
    }
    
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = UIColor(named: "Gray")
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Gray") ?? .lightGray]
        
        itemAppearance.selected.iconColor = UIColor(named: "Primary")
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary") ?? .white]
    }
}

protocol ServerListDelegate: class {
    func onServerTapped(with token: String)
}

class TestTabBarVC: UITabBarController, ServerListDelegate {
    
    deinit { print("* deinit -> TestTabBarVC") }
    
    var token: String?
    
    func onServerTapped(with token: String) {
        self.token = token

        print("** TestTabBarVC - token ibanii -> \(token)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension TestTabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {



        switch viewController {
        case is ServerInfoViewController:
            print("ooooopaaa")
        default:
            break
        }
    }
}
