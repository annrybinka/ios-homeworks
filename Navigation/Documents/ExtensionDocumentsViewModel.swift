import Foundation

extension DocumentsViewModel {
    
    struct Item {
        let title: String
        let isDirectory: Bool
    }
}

extension DocumentsViewModel: UserDefaultsObserver {
    func applySortState(isAlphabetical: Bool) {
        self.alphabeticalSortState = isAlphabetical
    }
}
