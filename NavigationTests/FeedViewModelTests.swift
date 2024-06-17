import XCTest
@testable import Navigation

final class FeedViewModelTests: XCTestCase {
    func test_whenWordCorrect_thenCorrectMessageShowed() throws {
        let model = FeedModelNoErrorsMock()
        let viewModel = FeedViewModel(feedModel: model)
        viewModel.сhangedGuess(word: "secret word")
        XCTAssertEqual(viewModel.alertState.text, "Вы угадали!")
    }

    func test_whenNoInternetError_thenCorrectMessageShowed() throws {
        let model = FeedModelNoInternetMock()
        let viewModel = FeedViewModel(feedModel: model)
        viewModel.сhangedGuess(word: "no internet")
        XCTAssertEqual(viewModel.alertState.text, "Проблемы с интернетом,\nпопробуйте позже")
    }
    
    func test_whenEmptyWordError_thenCorrectMessageShowed() throws {
        let model = FeedModelEmptyWordMock()
        let viewModel = FeedViewModel(feedModel: model)
        viewModel.сhangedGuess(word: "")
        XCTAssertEqual(viewModel.alertState.text, "Не угадали...\nпопробуйте ещё")
    }
    
    func test_whenWrongWordError_thenCorrectMessageShowed() throws {
        let model = FeedModelWrongWordMock()
        let viewModel = FeedViewModel(feedModel: model)
        viewModel.сhangedGuess(word: "wrong word")
        XCTAssertEqual(viewModel.alertState.text, "Не угадали...\nпопробуйте ещё")
    }
}
