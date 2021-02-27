//
//  ServerInfoTabBarController.swift
//  CS-MyArena
//
//  Created by Алик on 27.02.2021.
//

import UIKit

class ServerInfoTabBarController: UITabBarController {

    deinit { print("* deinit -> ServerInfoTabBarController") }
    
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupNavigation()
        setupTabBarController()
    }
    
    private func setupNavigation() {
        let serverId = 721
        self.title = "Server #\(serverId)"
    }
    
    private func setupTabBarController() {
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
        
        
        self.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0)}
//        self.setViewControllers(viewControllers, animated: true)
        
        let appearance = UITabBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = UIColor(named: "Background")
        setTabBarItemColors(appearance.stackedLayoutAppearance)
        
        self.tabBar.standardAppearance = appearance
    }
    
    private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.iconColor = UIColor(named: "Gray")
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Gray") ?? .lightGray]
        
        itemAppearance.selected.iconColor = UIColor(named: "Primary")
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary") ?? .white]
    }
}

extension ServerInfoTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        switch viewController {
        case is ServerInfoViewController:
            print("ooooopaaa")
        default:
            break
        }
    }
}
