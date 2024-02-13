import Foundation

protocol PasswordViewModelProtocol {
    var onButtonTitleDidChange: ((String) -> Void)? { get set }
    var onAlertMessageDidChange: ((String) -> Void)? { get set }
    var onClearPasswordFieldDidChange: ((Bool) -> Void)? { get set }
    func checkCurrentState()
    func check(password: String?)
}

enum PasswordState {
    case create //первый ввод нового пароля
    case `repeat`//подтверждение нового пароля
    case confirm //ввод ранее сохраненного пароля
}

final class PasswordViewModel: PasswordViewModelProtocol {
    private let model: PasswordModel
    private let coordinator: PasswordCoordinator
    private var state: PasswordState
    
    var onButtonTitleDidChange: ((String) -> Void)?
    private var buttonTitle: String = "" {
        didSet {
            onButtonTitleDidChange?(buttonTitle)
        }
    }
    
    var onAlertMessageDidChange: ((String) -> Void)?
    private var alertMessage: String = "" {
        didSet {
            onAlertMessageDidChange?(alertMessage)
        }
    }
    
    var onClearPasswordFieldDidChange: ((Bool) -> Void)?
    private var clearPasswordField: Bool = false {
        didSet {
            onClearPasswordFieldDidChange?(clearPasswordField)
        }
    }
    
    init(
        coordinator: PasswordCoordinator,
        state: PasswordState
    ) {
        self.model = PasswordModel()
        self.coordinator = coordinator
        self.state = state
    }
    
    func checkCurrentState() {
        switch state {
        case .create:
            buttonTitle = "Создать пароль"
        case .repeat:
            buttonTitle = "Повторите пароль"
        case .confirm:
            buttonTitle = "Введите пароль"
        }
    }
    
    func check(password: String?) {
        switch state {
        case .create:
            if model.validate(password: password) {
                state = .repeat
                clearPasswordField = true
                model.remember(password: password)
            } else {
                alertMessage = "пароль должен состоять минимум из четырёх символов"
                clearPasswordField = true
            }
        case .repeat:
            if model.checkRepeated(password: password) {
                if model.checkPasswordExists() {
                    //close modal view
                    print("===новый пароль сохранен")
                    model.save(password: password!)
                } else {
                    model.save(password: password!)
                    coordinator.startNextView()
                }
            } else {
                alertMessage = "пароль не совпал, повторите ещё раз или задайте новый пароль"
                state = .create
                clearPasswordField = true
            }
        case .confirm:
            let result = model.authenticate(password: password)
            switch result {
            case .success:
                coordinator.startNextView()
            case .failure(.noPassword):
                alertMessage = "вы не ввели пароль, если вам нужна помощь обратитесь в службу поддержки"
                clearPasswordField = true
            case .failure(.wrongPassword):
                alertMessage = "неверный пароль, попробуйте ещё раз"
                clearPasswordField = true
            }
        }
    }
}
