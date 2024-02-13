import UIKit

final class SettingsCoordinator: Coordinatable {
    var startViewController: UIViewController?
    
    func startView() -> UIViewController {
        let viewModel = SettingsViewModel(coordinator: self)
        let vc = SettingsViewController(viewModel: viewModel)
        vc.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 0)
        startViewController = UINavigationController(rootViewController: vc)

        return startViewController!
    }
    
    func startChangePasswordScreen() {
        let passwordCoordinator = PasswordCoordinator()
        let nc = startViewController?.navigationController
        nc?.modalTransitionStyle = .coverVertical
        nc?.modalPresentationStyle = .pageSheet
        startViewController?.present(passwordCoordinator.startCreatePasswordView(), animated: true)
    }
}
