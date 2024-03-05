import Foundation

final class AuthViewModel {
    private let authenticator: AuthenticatorProtocol
    private let storage: StorageProtocol
    private let coordinator: AuthCoordinator
    var currentUserID: String?
    
    var onAlertMessageDidChange: ((String) -> Void)?
    private(set) var alertMessage: String = "" {
        didSet {
            onAlertMessageDidChange?(alertMessage)
        }
    }
    
    init(
        authenticator: AuthenticatorProtocol,
        storage: StorageProtocol,
        coordinator: AuthCoordinator
    ) {
        self.authenticator = authenticator
        self.storage = storage
        self.coordinator = coordinator
    }
    
    func onViewLoaded() {
        alertMessage = "Подождите, идёт проверка..."
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            self?.storage.getSavedUser { user in
                guard user != nil else {
                    self?.alertMessage = "Мы вас не узнали, пожалуйста, введите логин и пароль"
                    return
                }
                self?.authenticator.authenticate(user: user!, handler: { result in
                    if result {
                        print("AuthViewModel: authenticate SavedUser success")
                        self?.coordinator.startNextView()
                    } else {
                        print("AuthViewModel: authenticate SavedUser fail")
                        self?.alertMessage = "Мы вас не узнали, пожалуйста, введите логин и пароль"
                    }
                })
            }
        }
    }
    
    func authenticate(login: String, password: String) {
        let user = AuthUser(id: UUID().uuidString, login: login, password: password)
        
        authenticator.authenticate(user: user) { result in
            if result {
                print("AuthViewModel: authenticate success")
                self.storage.save(newUser: user) { result in
                    if result {
                        print("AuthViewModel: save login password success")
                    } else {
                        print("AuthViewModel: save login password fail")
                    }
                }
                self.coordinator.startNextView()
            } else {
                print("AuthViewModel: authenticate fail")
                self.alertMessage = "При проверке возникла ошибка, повторите ввод.\nЕсли вы забыли логин или пароль, обратитесь в службу поддержки."
            }
        }
    }
}
