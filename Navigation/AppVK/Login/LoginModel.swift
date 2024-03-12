import Foundation

protocol LoginModelProtocol {
    func authenticate(login: String?, password: String?) -> Result<User, LoginModel.LoginError>
}

struct LoginModel: LoginModelProtocol {
    enum LoginError: Error {
        case noLogin
        case noPassword
        case wrongLoginPassword
    }
    
    let users: [User]
    
    func authenticate(login: String?, password: String?) -> Result<User, LoginModel.LoginError> {
        guard let login, !login.isEmpty else {
            return .failure(.noLogin)
        }
        guard let password, !password.isEmpty else {
            return .failure(.noPassword)
        }
        let user = users.first { $0.login == login && $0.password == password }
        guard let user else {
            return .failure(.wrongLoginPassword)
        }
        return .success(user)
    }
}
