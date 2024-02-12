import Foundation

protocol SettingsViewModelProtocol {
    func isSortStateAlphabetical() -> Bool
    func onSortPressed(alphabetical: Bool)
    func onChangePasswordPressed()
}

final class SettingsViewModel: SettingsViewModelProtocol {
    private let coordinator: SettingsCoordinator
    var userDefaultsService: UserDefaultsService?
    
    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
    }
    
    func isSortStateAlphabetical() -> Bool {
        userDefaultsService!.getSortState()
    }
    
    func onSortPressed(alphabetical: Bool) {
        userDefaultsService?.saveSortState(alphabetical: alphabetical)
        userDefaultsService?.notify()
    }
    
    func onChangePasswordPressed() {
        coordinator.startChangePasswordScreen()
    }
}
