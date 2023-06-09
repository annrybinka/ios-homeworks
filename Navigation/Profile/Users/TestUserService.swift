import UIKit

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
