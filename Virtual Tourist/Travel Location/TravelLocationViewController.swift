//
//  TravelLocationViewController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import UIKit
import MapKit

class TravelLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var viewModel: TravelLocationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataControllerManager = DataControllerManager(modelName: "VirtualTourist")
        viewModel = TravelLocationViewModel(dataControllerManager: dataControllerManager)
        viewModel.delegate = self // Assign the delegate to receive updates
        
        setupMap()
        setupMapGesture()
        viewModel.fetchSavedPins()
    }
}

// MARK: - TravelLocationViewModelDelegate
extension TravelLocationViewController: TravelLocationViewModelDelegate {
    func addAnnotation(_ annotation: MKPointAnnotation) {
        mapView.addAnnotation(annotation)
    }
    
    func reloadMapAnnotations(_ annotations: [MKPointAnnotation]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(annotations)
    }
}

// MARK: - Private Helpers
private extension TravelLocationViewController {
    func setupMap() {
        mapView.delegate = self
    }
    
    func setupMapGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            handleLongPressBegan(gestureRecognizer)
        }
    }
    
    func handleLongPressBegan(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        addPin(at: coordinate)
    }
    
    func addPin(at coordinate: CLLocationCoordinate2D) {
        viewModel.newAlbumAtLocation(at: coordinate)
        addPinToMap(at: coordinate)
        
    }
    
    func addPinToMap(at coordinate: CLLocationCoordinate2D) {
        let newPin = MKPointAnnotation()
        newPin.coordinate = coordinate
        mapView.addAnnotation(newPin)
    }
    
    func populateMapWithSavedPins() {
            mapView.removeAnnotations(mapView.annotations) // Clear existing pins before adding saved pins
            mapView.addAnnotations(viewModel.pins)
        }
}

extension TravelLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        if let annotation = view.annotation as? MKPointAnnotation {
            performSegue(withIdentifier: "toPhotoAlbum", sender: annotation)
        }
    }
}

// MARK: - Prepare for Segue
extension TravelLocationViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoAlbum",
           let photoGalleryViewController = segue.destination as? PhotoGalleryViewController,
           let annotation = sender as? MKPointAnnotation {
            if let pin = viewModel.pinObjects.first(where: { $0.latitude == annotation.coordinate.latitude && $0.longitude == annotation.coordinate.longitude }) {
                photoGalleryViewController.viewModel = viewModel.createPhotoGalleryViewModel(for: pin)
            }
        }
    }
}
