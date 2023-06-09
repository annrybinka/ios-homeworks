import UIKit

protocol UserService {
    func autorize(login: String) -> User?
}

final class CurrentUserService: UserService {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func autorize(login: String) -> User? {
        if user.login == login {
            return user
        } else {
            return nil
        }
    }
}

final class TestUserService: UserService {
    func autorize(login: String) -> User? {
        if user.login == login { return user } else { return nil }
    }
    
    let user = User(
        login: "test",
        fullName: "Test Name",
        avatar: UIImage(),
        status: "Test status"
    )
}
