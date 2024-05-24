import Foundation
import CoreLocation
import MapKit

protocol RouteBuilderProtocol {
    func calculateRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, handler: @escaping (MKRoute?) -> Void)
}

final class RouteBuilder: RouteBuilderProtocol {
    func calculateRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D, handler: @escaping (MKRoute?) -> Void) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: from))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: to))
        let direction = MKDirections(request: request)
        direction.calculate { responce, error in
            if let responce, let route = responce.routes.first {
                handler(route)
            } else {
                handler(nil)
            }
        }
    }
}
