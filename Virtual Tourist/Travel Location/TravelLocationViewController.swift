//
//  TravelLocationViewController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import UIKit
import MapKit

class TravelLocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var viewModel: TravelLocationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TravelLocationViewModel()
        mapView.delegate = self
        
        setupMapGesture()
    }
    
    private func setupMapGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.5 // Adjust as needed
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            handleLongPressBegan(gestureRecognizer)
        }
    }
    
    private func handleLongPressBegan(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        addPin(at: coordinate)
    }
    
    private func addPin(at coordinate: CLLocationCoordinate2D) {
        viewModel.addPin(at: coordinate)
        
        // Add the new pin to the map
        let newPin = MKPointAnnotation()
        newPin.coordinate = coordinate
        mapView.addAnnotation(newPin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Handle custom annotation views if needed
        return nil
    }
}




