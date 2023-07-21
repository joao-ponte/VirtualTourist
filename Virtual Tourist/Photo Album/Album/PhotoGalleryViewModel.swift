//
//  PhotoGalleryViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import Foundation
import MapKit

class PhotoGalleryViewModel {
    
    
    private let imageCollection = ["Image1", "Image2"]
    
    func getImages(index: Int) -> String {
        return imageCollection[index]
    }
    
    func countImages() -> Int {
        imageCollection.count
    }
    
    
}
