import UIKit

final class TabbarCoordinator: Coordinatable {
    
    func startView() -> UIViewController {
        let sort = UserDefaults.standard.object(forKey: "alphabeticalSortState")
        if sort == nil {
            UserDefaults.standard.set(true, forKey: "alphabeticalSortState")
        }
        let documentsCoordinator = DocumentsCoordinator()
        let setingsCoordinator = SettingsCoordinator()
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            documentsCoordinator.startView(),
            setingsCoordinator.startView()
        ]
        return tabBarController
    }
}
