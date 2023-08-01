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
            // Get the pin for the selected annotation
            guard let pin = viewModel?.getPinForAnnotation(annotation, completion: { result in
                switch result {
                case .success(let pin):
                    if let pin = pin {
                        // Initialize your view model here.
                        let dataControllerManager = DataControllerManager(modelName: "VirtualTourist")
                        self.viewModel = PhotoGalleryViewModel(dataControllerManager: dataControllerManager, pin: pin)
                        
                        // Ensure that the viewModel is not nil before proceeding.
                        if let viewModel = self.viewModel {
                            self.dataSource = PhotoGalleryDataSource(viewModel: viewModel)
                            self.collectionView.dataSource = self.dataSource
                            self.collectionView.reloadData()
                            
                            // Get the image URLs and print them
                            let imageURLs = viewModel.getImageURLs()
                            print("Image URLs: \(imageURLs)")
                        } else {
                            print("Failed to initialize viewModel.")
                        }
                    } else {
                        print("Failed to get the pin for the selected annotation.")
                    }
                case .failure(let error):
                    print("Error fetching pin: \(error)")
                }
            }) else {
                print("Failed to get the pin for the selected annotation.")
                return
            }
        }
    }

    @IBAction func createNewCollection(_ sender: Any) {
        // Implement the logic for creating a new collection here, if needed.
    }
}






