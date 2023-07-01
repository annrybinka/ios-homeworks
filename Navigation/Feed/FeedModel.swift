import Foundation

protocol FeedModelProtocol {
    func check(word: String) -> Bool
}

final class FeedModel: FeedModelProtocol {
    
    private let secretWord = "Hello"
    
    func check(word: String) -> Bool {
        secretWord == word
    }
}
