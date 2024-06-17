import UIKit
@testable import Navigation

struct LoginModelSuccessMock: LoginModelProtocol {
    func authenticate(login: String?, password: String?) -> Result<User, LoginModel.LoginError> {
        let userMock = User(
            login: "test",
            password: "1111",
            fullName: "Test Name",
            avatar: UIImage(named: "10") ?? UIImage(),
            status: "Test status"
        )
        return .success(userMock)
    }
}

struct LoginModelNoLoginMock: LoginModelProtocol {
    func authenticate(login: String?, password: String?) -> Result<User, LoginModel.LoginError> {
        return .failure(.noLogin)
    }
}

struct LoginModelNoPasswordMock: LoginModelProtocol {
    func authenticate(login: String?, password: String?) -> Result<User, LoginModel.LoginError> {
        return .failure(.noPassword)
    }
}

struct LoginModelWrongLoginPasswordMock: LoginModelProtocol {
    func authenticate(login: String?, password: String?) -> Result<User, LoginModel.LoginError> {
        return .failure(.wrongLoginPassword)
    }
}
