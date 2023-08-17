//
//  TravelLocationViewController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import UIKit
import MapKit

final class TravelLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var viewModel: TravelLocationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TravelLocationViewModel()
        mapView.region.center = viewModel.center
        mapView.region.span = viewModel.zoomLevel
        viewModel.saveLocationHasBeenLoaded()
        setMapView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navBarAppears(false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navBarAppears(true)
        viewModel.saveLastPosition(region: mapView.region)
    }

    // MARK: - MapView

    private func setMapView() {
        mapView.delegate = self

        if let pins = viewModel.pins {
            var annotations: [MKAnnotation] = []
            pins.forEach { pin in
                let coordinate = CLLocationCoordinate2D(latitude: pin.latitude,
                                                        longitude: pin.longitude)
                annotations.append(viewModel.createAnnotation(coordinate: coordinate))
            }
            mapView.addAnnotations(annotations)
        }

        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(longPressAction(gestureRecognizer:)))
        mapView.addGestureRecognizer(longPress)
    }

    @objc private func longPressAction(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UILongPressGestureRecognizer.State.ended {
            let touchLocation = gestureRecognizer.location(in: mapView)

            // convert CGPoint to CLLocationCoordinate2D
            let coordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            viewModel.plotNewPin(coordinate: coordinate,
                                 mapView: mapView)
        }
    }
    // MARK: - Photo Album View Model

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoAlbum" {
            guard
                let destination = segue.destination as? PhotoGalleryViewController,
                let annotationView = sender as? MKAnnotationView,
                let annotation = annotationView.annotation
            else { return }
            destination.viewModel = viewModel.makePhotoAlbumViewModel(coordinate: annotation.coordinate)
        }
    }
}
// MARK: - Map View Delegate
extension TravelLocationViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        performSegue(withIdentifier: "toPhotoAlbum", sender: view)
    }
}

// MARK: - Helpers
extension TravelLocationViewController {
    private func navBarAppears(_ isVisible: Bool) {
        navigationController?.setNavigationBarHidden(!isVisible,
                                                     animated: false)
    }
}

    
    
    
    
    
    
    
    
