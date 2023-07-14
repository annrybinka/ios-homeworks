import UIKit

final class ProfileCoordinator: Coordinatable {
    
    private weak var startViewController: UIViewController?

    func startView() -> UIViewController {
        let users = [
            User(
                login: "test",
                password: "1234",
                fullName: "Test Name",
                avatar: UIImage(),
                status: "Test status"
            ),
            User(
                login: "cat",
                password: "5678",
                fullName: "New Hipster Cat",
                avatar: UIImage(named: "cat") ?? UIImage(),
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
        let profileViewController = ProfileViewController(user: user)
        startViewController?.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
