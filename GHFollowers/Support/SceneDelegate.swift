//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by Onurcan Sever on 2023-11-26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        // Configuration for Programmatic UI.
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    // Methods for configuring app navigation.
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        
        // Tag: 0 -> Will appear as the first tab bar item on the left.
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        // Applying tint color of the tab bar app wide.
        UITabBar.appearance().tintColor = .systemGreen
        
        tabBarController.viewControllers = [createSearchNC(), createFavoritesNC()]
        
        return tabBarController
    }
    
    func configureNavigationBar() {
        // appearance() -> all of our navigation bars will have this specific styling.
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
}
