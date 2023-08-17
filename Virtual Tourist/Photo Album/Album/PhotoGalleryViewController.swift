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
        configurePhotoAlbumLayout()
        setupMapView()
        
        viewModel.reloadView = reloadData
        viewModel.fetchPhotos()
    }
    
    
    @IBAction func createNewLocation(_ sender: Any) {
        viewModel.createNewCollection()
    }
    
    // MARK: - Private Methods
    private func configurePhotoAlbumLayout() {
        
        let space: CGFloat = 3
        let dimension = (view.frame.size.width - (2 * space)) / space
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.updateView()
        }
    }
    
    private func updateView() {
        noImageView.isHidden = viewModel.isNoImageViewHidden
        newCollectionButton.isEnabled = viewModel.isNewCollectionEnabled
    }
    
    private func setupMapView() {
        let coordinate = CLLocationCoordinate2D(latitude: viewModel.latitude,
                                    longitude: viewModel.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
    }
    
}
