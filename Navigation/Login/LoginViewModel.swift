import Foundation

protocol LoginViewModelProtocol {
    var onAlertMessageDidChange: ((String) -> Void)? { get set }
    var onPasswordCracked: ((String) -> Void)? { get set }
    var onPasswordCrackingStarted: (() -> Void)? { get set }
    var onPasswordCrackingFinished: (() -> Void)? { get set }
    func userAuthenticate(login: String?, password: String?)
    func crackPassword()
}

final class LoginViewModel: LoginViewModelProtocol {
    var coordinator: ProfileCoordinator?
    var onAlertMessageDidChange: ((String) -> Void)?
    var onPasswordCracked: ((String) -> Void)?
    var onPasswordCrackingStarted: (() -> Void)?
    var onPasswordCrackingFinished: (() -> Void)?
    
    private(set) var alertMessage: String = "" {
        didSet {
            onAlertMessageDidChange?(alertMessage)
        }
    }
    
    private let loginModel: LoginModelProtocol
    
    init(loginModel: LoginModelProtocol) {
        self.loginModel = loginModel
    }
    
    func crackPassword() {
        onPasswordCrackingStarted?()
        
        let newPassword = loginModel.generatePassword()
        loginModel.users.first?.password = newPassword
        
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            let crackedPassword = self.loginModel.bruteForce(passwordToUnlock: newPassword)
            
            DispatchQueue.main.async {
                self.onPasswordCracked?(crackedPassword)
                self.onPasswordCrackingFinished?()
            }
        }
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
