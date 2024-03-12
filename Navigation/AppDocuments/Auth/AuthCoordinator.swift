import UIKit

final class AuthCoordinator: Coordinatable {
    private let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func startView() -> UIViewController {
        let id = UserDefaults.standard.string(forKey: "currentUserID")
        
        let authenticator = Authenticator()
        let storage = Storage()
        let viewModel = AuthViewModel(
            authenticator: authenticator,
            storage: storage,
            coordinator: self
        )
        viewModel.currentUserID = id
        let controller = AuthViewController(viewModel: viewModel)
        
        return controller
    }
    
    func startNextView() {
        appCoordinator.startMainApp()
    }
}
