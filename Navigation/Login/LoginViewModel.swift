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
        let result = loginModel.authenticate(login: login, password: password)
        switch result {
        case .success(let user):
//            preconditionFailure("Something happened with \(user)")
            successfulCheck(user: user)
        case .failure(.noLogin):
            alertMessage = "No login"
        case .failure(.noPassword):
            alertMessage = "No password"
        case .failure(.wrongLoginPassword):
            alertMessage = "Wrong login or password"
        }
    }
    
    func successfulCheck(user: User) {
        guard coordinator != nil else {
            preconditionFailure("Something happened with coordinator")
        }
        coordinator?.pushProfileViewController(user: user)
    }
}
