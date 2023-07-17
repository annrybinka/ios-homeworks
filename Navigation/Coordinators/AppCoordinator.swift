import UIKit

final class AppCoordinator: Coordinatable {
    
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
