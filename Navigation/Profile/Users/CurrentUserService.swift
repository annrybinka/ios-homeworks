import Foundation

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
