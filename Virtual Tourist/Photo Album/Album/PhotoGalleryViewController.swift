//
//  PhotoGalleryViewController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import UIKit
import MapKit

class PhotoGalleryViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var noImageView: UIView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var selectedAnnotation: MKAnnotation?
    var viewModel: PhotoGalleryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let annotation = selectedAnnotation {
                }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
        return cell
    }

    @IBAction func createNewCollection(_ sender: Any) {
    }
    
    
}
