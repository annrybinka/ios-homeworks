import UIKit

protocol FeedViewModelProtocol {
    var onAlertStateDidChange: ((FeedViewModel.AlertState) -> Void)? { get set }
    func сhangedGuess(word: String?)
    func onFeedPressed()
}

final class FeedViewModel: FeedViewModelProtocol {
    
    struct AlertState {
        let text: String
        let title: String
    }

    var onAlertStateDidChange: ((AlertState) -> Void)?
    
    var coordinator: FeedCoordinator?
    
    private(set) var alertState = AlertState(text: "Что-то пошло не так", title: "Ошибка") {
        didSet {
            onAlertStateDidChange?(alertState)
        }
    }
    
    private let feedModel: FeedModelProtocol
    
    init(feedModel: FeedModelProtocol) {
        self.feedModel = feedModel
    }
    
    func сhangedGuess(word: String?) {
        do {
            try feedModel.check(word: word)
            self.alertState = AlertState(
                text: "Вы угадали!",
                title: "Поздравляем"
            )
        } catch FeedModel.CheckError.noInternet {
            self.alertState = AlertState(
                text: "Проблемы с интернетом,\nпопробуйте позже",
                title: "Ошибка"
            )
        } catch {
            self.alertState = AlertState(
                text: "Не угадали...\nпопробуйте ещё",
                title: "=("
            )
        }
    }
    
    func onFeedPressed() {
        guard coordinator != nil else {
            preconditionFailure("Something happened with coordinator")
        }
        coordinator?.pushPostViewController()
    }
}
