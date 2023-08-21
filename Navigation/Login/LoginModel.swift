import Foundation

protocol LoginModelProtocol {
    var users: [User] {get set}
    func authenticate(login: String, password: String) -> User?
    func generatePassword() -> String
    func bruteForce(passwordToUnlock: String) -> String
}

struct LoginModel: LoginModelProtocol {
    var users: [User]
    
    func authenticate(login: String, password: String) -> User? {
        users.first { $0.login == login && $0.password == password }
    }
    
    func generatePassword() -> String {
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var password: String = ""
        while password.count < 4 {
            password = password + (allowedCharacters.randomElement() ?? "")
        }
        
        return password
    }
    
    func bruteForce(passwordToUnlock: String) -> String {
        let bruteForce = BruteForce()
        let crackedPassword = bruteForce.bruteForce(passwordToUnlock: passwordToUnlock)
        
        return crackedPassword
    }
}
