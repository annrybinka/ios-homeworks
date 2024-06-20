import UIKit
@testable import Navigation

final class ProfileCoordinatorMock: ProfileCoordinatorProtocol {
    var isProfileScreenOpened = false
    
    func pushProfileViewController(user: Navigation.User) {
        isProfileScreenOpened = true
    }
    
    func startView() -> UIViewController {
        UIViewController()
    }
}
