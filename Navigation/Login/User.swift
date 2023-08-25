import UIKit

final class User {
    let login: String
    var password: String
    let fullName: String
    let avatar: UIImage
    let status: String
    
    init(login: String, password: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.password = password
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
