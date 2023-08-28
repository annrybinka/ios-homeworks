import UIKit

protocol FeedViewModelProtocol {
    var onViewStateDidChange: ((FeedViewModel.ViewState) -> Void)? { get set }
    func onWordChanged(word: String?)
    func onFeedPressed()
}

final class FeedViewModel: FeedViewModelProtocol {
    
    struct ViewState {
        let text: String
        let color: UIColor
    }

    var onViewStateDidChange: ((ViewState) -> Void)?
    
    var coordinator: FeedCoordinator?
    
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
        do {
            try feedModel.check(word: word)
            self.viewState = ViewState(text: "Угадали!", color: .green)
        } catch FeedModel.CheckError.emptyWord {
            self.viewState = ViewState(text: "", color: .white)
        } catch FeedModel.CheckError.wrongWord {
            self.viewState = ViewState(text: "Не угадали...", color: .red)
        } catch {
            self.viewState = ViewState(text: "", color: .white)
        }
    }
    
    func onFeedPressed() {
//        preconditionFailure
        coordinator?.pushPostViewController()
    }
}
