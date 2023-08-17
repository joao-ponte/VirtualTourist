//
//  PhotoGalleryDelegate.swift
//  Virtual Tourist
//
//  Created by João Ponte on 17/08/2023.
//

import UIKit

final class PhotoGalleryDelegate: NSObject, UICollectionViewDelegate {
    private let viewModel: PhotoGalleryViewModel
    
    init(viewModel: PhotoGalleryViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.deleteImage(at: indexPath.row)
    }
}
