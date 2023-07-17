import Foundation

protocol LoginViewModelProtocol {
    var onAlertMessageDidChange: ((String) -> Void)? { get set }
    func userAuthenticate(login: String?, password: String?)
}

final class LoginViewModel: LoginViewModelProtocol {
    var coordinator: ProfileCoordinator?
    var onAlertMessageDidChange: ((String) -> Void)?
    
    private(set) var alertMessage: String = "" {
        didSet {
            onAlertMessageDidChange?(alertMessage)
        }
    }
    
    private let loginModel: LoginModelProtocol
    
    init(loginModel: LoginModelProtocol) {
        self.loginModel = loginModel
    }
    
    func userAuthenticate(login: String?, password: String?) {
        guard let login, !login.isEmpty else {
            alertMessage = "No login"
            return
        }
        guard let password, !password.isEmpty else {
            alertMessage = "No password"
            return
        }
        let user = loginModel.authenticate(login: login, password: password)
        guard let user else {
            alertMessage = "Wrong login or password"
            return
        }
        
        successfulCheck(user: user)
    }
    
    func successfulCheck(user: User) {
        coordinator?.pushProfileViewController(user: user)
    }
}
