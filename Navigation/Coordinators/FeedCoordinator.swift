import UIKit

final class FeedCoordinator: Coordinatable {
    private weak var startViewController: UIViewController?

    func startView() -> UIViewController {
        let feedModel = FeedModel()
        let feedViewModel = FeedViewModel(feedModel: feedModel)
        feedViewModel.coordinator = self
        let feedViewController = FeedViewController(feedViewModel: feedViewModel)
       
        feedViewController.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "line.horizontal.3"),
            tag: 0
        )
       
        startViewController = feedViewController
        
        return feedViewController
    }
    
    func pushPostViewController() {
        let postViewController = PostViewController()
        postViewController.title = "Мои рецепты"
        startViewController?.navigationController?.pushViewController(postViewController, animated: true)
    }
}
