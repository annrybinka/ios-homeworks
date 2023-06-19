import Foundation

class Checker {
    static let defaultChecker = Checker()
    
    private init() {}
    private let login = "1234"
    private let password = "1234"
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
}
