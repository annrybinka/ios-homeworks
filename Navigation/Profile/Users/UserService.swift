import Foundation

protocol UserService {
    func autorize(login: String) -> User?
}
