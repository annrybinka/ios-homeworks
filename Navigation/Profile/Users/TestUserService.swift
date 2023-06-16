import UIKit

final class TestUserService: UserService {
    let user = User(
        login: "test",
        fullName: "Test Name",
        avatar: UIImage(),
        status: "Test status"
    )
    
    func autorize(login: String) -> User? {
        if user.login == login {
            return user
        } else {
            return nil
        }
    }
}
