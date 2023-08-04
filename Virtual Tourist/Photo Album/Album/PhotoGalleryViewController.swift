//
//  PhotoGalleryViewController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import UIKit
import MapKit

class PhotoGalleryViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var selectedCoordinate: CLLocationCoordinate2D?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let coordinate = selectedCoordinate {
            addPinToMap(at: coordinate)
            zoomToSelectedCoordinate(coordinate)
        }
    }

    func addPinToMap(at coordinate: CLLocationCoordinate2D) {
        let newPin = MKPointAnnotation()
        newPin.coordinate = coordinate
        mapView.addAnnotation(newPin)
        mapView.setCenter(coordinate, animated: true)
    }

    private func zoomToSelectedCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let zoomLevel: CLLocationDistance = 3000
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: zoomLevel, longitudinalMeters: zoomLevel)
        mapView.setRegion(region, animated: true)
    }
    
    
    
}

