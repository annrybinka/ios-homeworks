import Foundation
@testable import Navigation

final class FeedModelNoErrorsMock: FeedModelProtocol {
    func check(word: String?) throws { }
}

final class FeedModelNoInternetMock: FeedModelProtocol {
    func check(word: String?) throws {
        throw FeedModel.CheckError.noInternet
    }
}

final class FeedModelEmptyWordMock: FeedModelProtocol {
    func check(word: String?) throws {
        throw FeedModel.CheckError.emptyWord
    }
}

final class FeedModelWrongWordMock: FeedModelProtocol {
    func check(word: String?) throws {
        throw FeedModel.CheckError.wrongWord
    }
}
