import UIKit

final class TabbarCoordinator: Coordinatable {
    var appCoordinator: AppCoordinator?
    private let userDefaults: UserDefaultsService = UserDefaultsService.create
    
    func startView() -> UIViewController {
        userDefaults.setStartSortState(alphabetical: true)
        
        let documentsCoordinator = DocumentsCoordinator()
        documentsCoordinator.userDefaults = userDefaults
        
        let setingsCoordinator = SettingsCoordinator()
        setingsCoordinator.userDefaults = userDefaults
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            documentsCoordinator.startView(),
            setingsCoordinator.startView()
        ]
        return tabBarController
    }
}
