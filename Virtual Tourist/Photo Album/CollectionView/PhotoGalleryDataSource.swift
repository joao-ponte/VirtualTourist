//
//  PhotoGalleryDataSource.swift
//  Virtual Tourist
//
//  Created by João Ponte on 25/07/2023.
//

import UIKit

class PhotoGalleryDataSource: NSObject, UICollectionViewDataSource {
    
    let placeholder = UIImage(named: "photoPlaceHolder")
    
    let viewModel: PhotoGalleryViewModel
    init(viewModel: PhotoGalleryViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell",
                                                            for: indexPath) as? PhotoGalleryCell else {
            fatalError("error🥸: collectionViewCell is not a type PhotoGalleryCell")
        }
        
        cell.imageView.image = viewModel.image(at: indexPath.row) ?? placeholder
        return cell
    }
}
