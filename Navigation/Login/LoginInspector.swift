import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool {
        Checker.defaultChecker.check(login: login, password: password)
    }
    
}
