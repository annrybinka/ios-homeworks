import Foundation

protocol UserDefaultsObserver {
    func applySortState(isAlphabetical: Bool)
}

public struct UserDefaultsService {
    static var create: UserDefaultsService = {
        let userDefaultsService = UserDefaultsService()
        
        return userDefaultsService
    }()
    
    private let userDefaults = UserDefaults.standard
    private var observers: [UserDefaultsObserver] = []
    
    private init() {}
    
    mutating func add(observer: UserDefaultsObserver) {
        observers.append(observer)
    }
    
    func remove(observer: UserDefaultsObserver) {
//        TODO: remove observer
    }
    
    func notify() {
        print("=== SortState in UD alphabetical: \(self.getSortState())")
        observers.forEach { $0.applySortState(isAlphabetical: self.getSortState()) }
    }
    
    func setStartSortState(alphabetical: Bool) {
        userDefaults.set(alphabetical, forKey: "SortState")
    }
    
    func saveSortState(alphabetical: Bool) {
        userDefaults.setValue(alphabetical, forKey: "SortState")
        print("===in UD save SortState alphabetical: \(userDefaults.bool(forKey: "SortState"))")
    }
    
    func getSortState() -> Bool {
        userDefaults.bool(forKey: "SortState")
    }
}
