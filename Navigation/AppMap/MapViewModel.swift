import Foundation
import MapKit
import CoreLocation

final class MapViewModel: NSObject {
    private let routeBuilder: RouteBuilderProtocol
    private let locationManager = CLLocationManager()
//    var authorizationStatus: Bool = true 
    
//    var onShowAlert: ((Bool) -> Void)?
//    private(set) {
//        didSet {
//            onShowAlert?(!authorizationStatus)
//        }
//    }
    
    var onRouteDidChange: ((MKRoute) -> Void)?
    private(set) var route: MKRoute = MKRoute() {
        didSet {
            onRouteDidChange?(route)
        }
    }
    
    init(routeBuilder: RouteBuilderProtocol) {
        self.routeBuilder = routeBuilder
    }

    func onViewLoaded() {
        if locationManager.authorizationStatus == .denied {
//            authorizationStatus = false
            print("authorizationStatus is denied")
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func getRoute(destination: CLLocationCoordinate2D) {
        let userCoordinate = locationManager.location?.coordinate
        guard let userCoordinate else {
            print("userCoordinate = nil")
            return
        }
        routeBuilder.calculateRoute(from: userCoordinate, to: destination) { [weak self] route in
            guard let route else {
                print("route = nil")
                return
            }
            self?.route = route
        }
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
    }
}
