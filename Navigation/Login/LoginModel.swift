import Foundation

protocol LoginModelProtocol {
    func authenticate(login: String, password: String) -> User?
}

struct LoginModel: LoginModelProtocol {
    let users: [User] 
    
    func authenticate(login: String, password: String) -> User? {
        users.first { $0.login == login && $0.password == password }
    }
}
