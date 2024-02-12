import UIKit

final class PasswordCoordinator: Coordinatable {
    var appCoordinator: AppCoordinator?
    
    func startView() -> UIViewController {
        let model = PasswordModel()
        
        var state: PasswordState? = nil
        if model.checkPasswordExists() {
            state = .confirm
        } else {
            state = .create
        }
        
        let viewModel = PasswordViewModel(
            model: model,
            coordinator: self,
            state: state!
        )
        return PasswordViewController(passwordViewModel: viewModel)
    }
    
    func startCreatePasswordView() -> UIViewController {
        let model = PasswordModel()
        
        let viewModel = PasswordViewModel(
            model: model,
            coordinator: self,
            state: .create
        )
        return PasswordViewController(passwordViewModel: viewModel)
    }
    
    func startNextView() {
        appCoordinator?.startMainApp()
    }
}
