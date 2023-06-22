import Foundation

class Checker {
    static let defaultChecker = Checker()
    
    private init() {}
    private let login = "test"
    private let password = "1234"
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
}
