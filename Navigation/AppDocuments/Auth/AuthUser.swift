import Foundation

struct AuthUser {
    let id: String
    let login: String
    let password: String
    
    var keyedValues: [String: Any] {
        [
            "id": id,
            "login": login,
            "password": password
        ]
    }
}
