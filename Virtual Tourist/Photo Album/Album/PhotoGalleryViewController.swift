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
    @IBOutlet weak var noImageView: UIView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var selectedAnnotation: MKAnnotation?
    var viewModel: PhotoGalleryViewModel?
    var dataSource: PhotoGalleryDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let annotation = selectedAnnotation {
            // Initialize your view model here.
//            viewModel = PhotoGalleryViewModel(annotation: annotation)
            
            // Ensure that the viewModel is not nil before proceeding.
            if let viewModel = viewModel {
                dataSource = PhotoGalleryDataSource(viewModel: viewModel)
                collectionView.dataSource = dataSource
                collectionView.reloadData()
            } else {
                print("Failed to initialize viewModel.")
            }
        }
    }

    @IBAction func createNewCollection(_ sender: Any) {
        // Implement the logic for creating a new collection here, if needed.
    }
}

