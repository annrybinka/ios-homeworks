import UIKit

final class ProfileCoordinator: Coordinatable {

    func startView() -> UIViewController {
#if DEBUG
        let userService = TestUserService()
#else
        let realUser = User(
            login: "test",
            fullName: "New Hipster Cat",
            avatar: UIImage(named: "cat") ?? UIImage(),
            status: "Everything is difficult"
        )
        let userService = CurrentUserService(user: realUser)
#endif
        let logInViewController = LogInViewController(userService: userService)
        logInViewController.loginDelegate = MyLoginFactory.makeLoginInspector()
        logInViewController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person.crop.circle.fill"),
            tag: 1
        )
        
        return logInViewController
    }
}
