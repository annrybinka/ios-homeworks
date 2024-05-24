import UIKit

final class MapCoordinator: Coordinatable {
    private let appCoordinator: AppCoordinator
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    func startView() -> UIViewController {
        let viewModel = MapViewModel(routeBuilder: RouteBuilder())
        let controller = MapViewController(viewModel: viewModel)
        
        return controller
    }
}
