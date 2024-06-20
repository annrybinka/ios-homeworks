import XCTest
@testable import Navigation

final class LoginViewModelTests: XCTestCase {
    func test_whenLoginAndPasswordAreCorrect_thenNextScreenShowed() throws {
        let viewModel = LoginViewModel(loginModel: LoginModelSuccessMock())
        let coordinator = ProfileCoordinatorMock()
        viewModel.coordinator = coordinator
        coordinator.isProfileScreenOpened = false
        viewModel.userAuthenticate(login: "test", password: "1111")
        XCTAssertTrue(coordinator.isProfileScreenOpened)
    }
    
    func test_whenWrongLoginOrPasswordError_thenCorrectMessageShowed() throws {
        let viewModel = LoginViewModel(loginModel: LoginModelWrongLoginPasswordMock())
        viewModel.userAuthenticate(login: "", password: "")
        XCTAssertEqual(viewModel.alertMessage, "Wrong login or password")
    }
    
    func test_whenNoLoginError_thenCorrectMessageShowed() throws {
        let viewModel = LoginViewModel(loginModel: LoginModelNoLoginMock())
        viewModel.userAuthenticate(login: nil, password: "1111")
        XCTAssertEqual(viewModel.alertMessage, "No login")
    }
    
    func test_whenNoPasswordError_thenCorrectMessageShowed() throws {
        let viewModel = LoginViewModel(loginModel: LoginModelNoPasswordMock())
        viewModel.userAuthenticate(login: "test", password: "")
        XCTAssertEqual(viewModel.alertMessage, "No password")
    }
}
