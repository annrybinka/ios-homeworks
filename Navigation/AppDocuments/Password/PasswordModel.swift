import Foundation
import KeychainAccess

final class PasswordModel {
    private var firstPassword: String?
    let keychain = Keychain()
    
    enum PasswordError: Error {
        case noPassword
        case wrongPassword
    }
    
    func checkPasswordExists() -> Bool {
        let savedPassword = try? keychain.getString("userPassword")
        if savedPassword != nil {
            return true
        } else {
            return false
        }
    }
    
    func validate(password: String?) -> Bool {
        guard let password else { return false }
        if password.count < 4 {
            return false
        }
        return true
    }
    
    func remember(password: String?) {
        self.firstPassword = password
    }
    
    func checkRepeated(password: String?) -> Bool {
        if password == firstPassword {
            return true
        } else {
            return false
        }
    }
    
    func save(password: String) {
        keychain["userPassword"] = password
    }
    
    func authenticate(password: String?) -> Result<Bool, PasswordModel.PasswordError> {
        guard let password, !password.isEmpty else {
            return .failure(.noPassword)
        }
        let savedPassword = try? keychain.getString("userPassword")
        guard password == savedPassword else {
            return .failure(.wrongPassword)
        }
        return .success(true)
    }
}
