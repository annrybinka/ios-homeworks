import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let profileImage: UIImage? = .init(named: "profile")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
                
        let controllers = createViewControllers()
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        
        tabBarController.selectedIndex = 0
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    func createViewControllers() -> [UIViewController] {
        let feedViewController = FeedViewController()
        feedViewController.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "line.horizontal.3"),
            tag: 0
        )
#if DEBUG
        let userService = TestUserService()
#else
        let realUser = User(
            login: "1234",
            fullName: "New Hipster Cat",
            avatar: UIImage(named: "cat") ?? UIImage(),
            status: "Everything is difficult"
        )
        let userService = CurrentUserService(user: realUser)
#endif
        let logInViewController = LogInViewController(userService: userService)
        logInViewController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person.crop.circle.fill"),
            tag: 1
        )
        
        return [feedViewController, logInViewController]
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}

