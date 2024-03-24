import UIKit

final class FavoritesCoordinator: Coordinatable {
    func startView() -> UIViewController {
        let viewModel = FavoritesViewModel(storage: PostStorage())
        let controller = FavoritesViewController(viewModel: viewModel)
        controller.tabBarItem = UITabBarItem(
            title: "Избранное",
            image: UIImage(systemName: "star"),
            tag: 2
        )
        
        return controller
    }
}
