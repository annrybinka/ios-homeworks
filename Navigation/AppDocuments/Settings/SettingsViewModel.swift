import Foundation

protocol SettingsViewModelProtocol {
    func isSortStateAlphabetical() -> Bool
    func onSortPressed(isAlphabetical: Bool)
    func onChangePasswordPressed()
}

final class SettingsViewModel: SettingsViewModelProtocol {
    private let coordinator: SettingsCoordinator
    
    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
    }
    
    func isSortStateAlphabetical() -> Bool {
        UserDefaults.standard.bool(forKey: "alphabeticalSortState")
    }
    
    func onSortPressed(isAlphabetical: Bool) {
        UserDefaults.standard.setValue(isAlphabetical, forKey: "alphabeticalSortState")
    }
    
    func onChangePasswordPressed() {
        coordinator.startChangePasswordScreen()
    }
}
