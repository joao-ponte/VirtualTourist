//
//  PhotoGalleryDataSource.swift
//  Virtual Tourist
//
//  Created by João Ponte on 25/07/2023.
//

import UIKit


class PhotoGalleryDataSource: NSObject, UICollectionViewDataSource {
    private let viewModel: PhotoGalleryViewModel
    
    init(viewModel: PhotoGalleryViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countImages()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoGalleryCell
//        let imageUrl = viewModel.getImageUrl(for: indexPath.row)
        // Configure the cell with the image using the URL.
        // cell.imageView.loadImage(from: imageUrl) // Example of loading image from URL.
        
        return cell
    }
}

