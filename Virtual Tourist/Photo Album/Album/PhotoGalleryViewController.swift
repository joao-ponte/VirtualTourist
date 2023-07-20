//
//  PhotoGalleryViewController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import UIKit
import MapKit

class PhotoGaleryViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var noImageView: UIView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    var viewModel: PhotoGalleryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
