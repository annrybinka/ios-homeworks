//
//  AppDelegate.swift
//  Navigation
//
//  Created by Zhukova on 01.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let tabBar = UITabBarController()
    
    let feedView = UIViewController()
    feedView.title = "Лента новостей"
    feedView.view.backgroundColor = .blue
    feedView.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
    
    let profileView = UIViewController()
    profileView.title = "Профиль"
    profileView.view.backgroundColor = .gray
    profileView.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
    
    let controllers = [feedView, profileView]
    tabBar.viewControllers = controllers.map(
        UINavigationController(rootViewController: $0)
    )
    
    tabBar.selectedIndex = 0
    
    let postView = UIViewController()
    postView.title = "Просмотр поста"
    postView.view.backgroundColor = .cyan
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

