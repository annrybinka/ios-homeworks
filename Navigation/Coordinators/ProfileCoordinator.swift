import UIKit

final class ProfileCoordinator: Coordinatable {
    private weak var startViewController: UIViewController?

    func startView() -> UIViewController {
        let users = [
            User(
                login: "test",
                password: "1111",
                fullName: "Test Name",
                avatar: UIImage(named: "10") ?? UIImage(),
                status: "Test status"
            ),
            User(
                login: "thebestgirl",
                password: "1234",
                fullName: "Phoebe Buffay",
                avatar: UIImage(named: "20") ?? UIImage(),
                status: "Everything is difficult"
            )
        ]
        let loginModel = LoginModel(users: users)
        let loginViewModel = LoginViewModel(loginModel: loginModel)
        loginViewModel.coordinator = self
        let logInViewController = LogInViewController(loginViewModel: loginViewModel)
        logInViewController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person.crop.circle.fill"),
            tag: 1
        )
        startViewController = logInViewController
        return logInViewController
    }
    
    func pushProfileViewController(user: User) {
        let profileViewController = ProfileViewController(user: user, storage: PostStorage())
        startViewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
