import UIKit

protocol FeedViewModelProtocol {
    var onViewStateDidChange: ((FeedViewModel.ViewState) -> Void)? { get set }
    func onWordChanged(word: String?)
}

final class FeedViewModel: FeedViewModelProtocol {
    
    struct ViewState {
        let text: String
        let color: UIColor
    }

    var onViewStateDidChange: ((ViewState) -> Void)?
    
    private(set) var viewState = ViewState(text: "", color: .white) {
        didSet {
            onViewStateDidChange?(viewState)
        }
    }
    
    private let feedModel: FeedModelProtocol
    
    init(feedModel: FeedModelProtocol) {
        self.feedModel = feedModel
    }
    
    func onWordChanged(word: String?) {
        guard let word, !word.isEmpty else {
            self.viewState = ViewState(text: "", color: .white)
            return
        }
        let result = feedModel.check(word: word)
        switch result {
        case true:
            self.viewState = ViewState(text: "Угадали!", color: .green)
        case false:
            self.viewState = ViewState(text: "Не угадали...", color: .red)
        }
    }
}
