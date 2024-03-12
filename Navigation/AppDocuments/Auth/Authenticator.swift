import Foundation

protocol AuthenticatorProtocol {
    func authenticate(
        user: AuthUser,
        handler: @escaping (Bool) -> Void
    )
}

final class Authenticator: AuthenticatorProtocol {
    private let userLogin = "test"
    private let userPassword = "1111"
    
    func authenticate(user: AuthUser, handler: @escaping (Bool) -> Void) {
        if user.login == userLogin, user.password == userPassword {
            handler(true)
        } else {
            handler(false)
        }
    }
}
