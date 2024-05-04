import UIKit
import MapKit

class MapViewController: UIViewController {
    private var viewModel: MapViewModel
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        view.showsUserTrackingButton = true
        view.showsUserLocation = true
        view.delegate = self
        
        return view
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Стандарт", "Спутник", "Гибрид"])
        view.selectedSegmentIndex = 0
        view.backgroundColor = .white
        view.addTarget(self, action: #selector(changeMapType), for: .valueChanged)
        
        return view
    }()
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addGestureRecognizer()
        viewModel.onViewLoaded()
        viewModel.onRouteDidChange = { [weak self] route in
            self?.mapView.addOverlay(route.polyline)
            self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
        viewModel.onShowAlert = { [weak self] status in
            self?.showSettingsAlert()
        }
    }
    
    private func setUpUI() {
        mapView.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -38)
        ])
    }
    
    private func addAnnotation(coordinates: CLLocationCoordinate2D, title: String) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        pin.title = title
        mapView.addAnnotation(pin)
    }
    
    private func showSettingsAlert() {
        let alert = UIAlertController(
            title: "Выключена служба геолокации",
            message: "Для стабильной работы приложения необходимо предоставить доступ к вашей геолокации в настройках.",
            preferredStyle: .alert
        )
        let OkAction = UIAlertAction(title: "Перейти в настройки", style: .default) {_ in
            if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Отложить", style: .default) {_ in }
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    private func showRouteAlert(for annotation: MKAnnotation) {
        let routeAlert = UIAlertController(
            title: nil,
            message: "Построить маршрут до этой точки?",
            preferredStyle: .actionSheet
        )
        let OkAction = UIAlertAction(title: "да", style: .default) {_ in
            self.viewModel.getRoute(destination: annotation.coordinate)
        }
        let cancelAction = UIAlertAction(title: "нет", style: .default) {_ in }
        routeAlert.addAction(OkAction)
        routeAlert.addAction(cancelAction)
        present(routeAlert, animated: true)
    }
    
    private func addGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: mapView)
        let coordinates = mapView.convert(point, toCoordinateFrom: mapView)
        addAnnotation(coordinates: coordinates, title: "Pin")
    }
    
    @objc func changeMapType(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: any MKAnnotation) {
        showRouteAlert(for: annotation)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .systemPink
            render.lineWidth = 7
            return render
        }
        return MKOverlayRenderer()
    }
}
