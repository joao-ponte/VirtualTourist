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
        viewModel = TravelLocationViewModel(dataControllerManager: dataControllerManager)
        
        setupMap()
        setupMapGesture()
        populateMapWithSavedPins()
    }
}

// MARK: - MKMapViewDelegate
extension TravelLocationViewController: MKMapViewDelegate {
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
    }
    
    func populateMapWithSavedPins() {
        for pin in viewModel.pins {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
            mapView.addAnnotation(annotation)
        }
    }
}





