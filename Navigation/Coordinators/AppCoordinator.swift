import UIKit

final class AppCoordinator: Coordinatable {
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func startApp() {
        startPasswordScreen()
    }
    
    func startMapApp() {
        let coordinator = MapCoordinator(appCoordinator: self)
        navigationController = UINavigationController(rootViewController: coordinator.startView())
        window?.rootViewController = navigationController
    }
    
    func startPasswordScreen() {
        let passwordCoordinator = PasswordCoordinator()
        passwordCoordinator.appCoordinator = self
        let vc = passwordCoordinator.startView()
        window?.rootViewController = vc
    }
    
    func startAuthScreen() {
        let coordinator = AuthCoordinator(appCoordinator: self)
        navigationController = UINavigationController(rootViewController: coordinator.startView())
        window?.rootViewController = navigationController
    }
    
    func startMainApp() {
        let tabbarCoordinator = TabbarCoordinator()
        navigationController?.pushViewController(tabbarCoordinator.startView(), animated: true)
    }
    
    func startView() -> UIViewController {
        let feedCoordinator = FeedCoordinator()
        let profileCoordinator = ProfileCoordinator()
        let favoritesCoordinator = FavoritesCoordinator()
        let controllers = [
            feedCoordinator.startView(),
            profileCoordinator.startView(),
            favoritesCoordinator.startView()
        ]
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        tabBarController.selectedIndex = 1

        return tabBarController
    }
}
