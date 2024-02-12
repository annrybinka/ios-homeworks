import UIKit

final class AppCoordinator: Coordinatable {
    var window: UIWindow?
    
    func startPasswordScreen() {
        let passwordCoordinator = PasswordCoordinator()
        passwordCoordinator.appCoordinator = self
        let vc = passwordCoordinator.startView()
        window?.rootViewController = vc
    }
    
    func startMainApp() {
        let tabbarCoordinator = TabbarCoordinator()
        tabbarCoordinator.appCoordinator = self
        window?.rootViewController = tabbarCoordinator.startView()
    }
    
    func startView() -> UIViewController {
        let feedCoordinator = FeedCoordinator()
        let profileCoordinator = ProfileCoordinator()
        let controllers = [feedCoordinator.startView(), profileCoordinator.startView()]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        
        tabBarController.selectedIndex = 1

        return tabBarController
    }
}
