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
        
        let dataControllerManager = DataControllerManager.shared
        let flickrAPI = FlickrAPI()
        viewModel = TravelLocationViewModel(dataControllerManager: dataControllerManager, imageRepository: flickrAPI)
        
        setupMap()
        setupMapGesture()
        populateMapWithSavedPins()
    }
    
    
    
}

// MARK: - MKMapViewDelegate
extension TravelLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            performSegue(withIdentifier: "toPhotoAlbum", sender: annotation)
        }
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
        viewModel.addPin(at: coordinate)
        addPinToMap(at: coordinate)
        
        viewModel.savePins()
    }
    
    func addPinToMap(at coordinate: CLLocationCoordinate2D) {
        let newPin = MKPointAnnotation()
        newPin.coordinate = coordinate
        mapView.addAnnotation(newPin)
    }
    
    func populateMapWithSavedPins() {
        for pin in viewModel.pins {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
            mapView.addAnnotation(annotation)
        }
    }
}

// MARK: - Prepare for Segue
extension TravelLocationViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoAlbum",
           let photoGalleryViewController = segue.destination as? PhotoGalleryViewController,
           let annotation = sender as? MKPointAnnotation {
            photoGalleryViewController.selectedAnnotation = annotation
        }
    }
}
