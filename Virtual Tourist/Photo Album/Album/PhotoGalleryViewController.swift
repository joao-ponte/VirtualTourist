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
    @IBOutlet weak var noImageView: UIView!
    
    var viewModel: PhotoGalleryViewModel!
    
    lazy var photoGalleryDataSource = PhotoGalleryDataSource(viewModel: viewModel)
    lazy var photoGalleryDelegate = PhotoGalleryDelegate(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoGalleryDataSource
        collectionView.delegate = photoGalleryDelegate
    }
}





