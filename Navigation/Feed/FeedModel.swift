import Foundation

protocol FeedModelProtocol {
    func check(word: String?) throws
}

final class FeedModel: FeedModelProtocol {
    enum CheckError: Error {
        case emptyWord
        case wrongWord
        case noInternet
    }
    
    private let secretWord = "Hello"
    
    func check(word: String?) throws {
        guard let word, !word.isEmpty else { throw CheckError.emptyWord }
        guard secretWord == word else { throw CheckError.wrongWord }
//        throw CheckError.noInternet
//        строчка выше имитирует отсутствие интернет соединения
    }
}
