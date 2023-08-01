//
//  PhotoGalleryViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import Foundation
import MapKit

class PhotoGalleryViewModel {
    private let dataControllerManager: DataControllerProtocol
    private let pin: Pin

    init(dataControllerManager: DataControllerProtocol, pin: Pin) {
        self.dataControllerManager = dataControllerManager
        self.pin = pin
    }

    func countImages() -> Int {
        return getImageURLs().count
    }

    func getImageURL(for index: Int) -> URL? {
        let imageURLs = getImageURLs()
        guard index >= 0 && index < imageURLs.count else {
            return nil
        }
        return imageURLs[index]
    }

    func getImageURLs() -> [URL] {
        // Use the dataControllerManager to get the imageURLs associated with the given pin
        if let albumID = pin.album?.id, let images = dataControllerManager.getImages(for: albumID) {
            return images.compactMap { URL(string: $0.imageUrl ?? "") }
        }
        return []
    }

    func getPinForAnnotation(_ annotation: MKAnnotation, completion: @escaping (Result<Pin?, Error>) -> Void) {
        dataControllerManager.fetchPins { result in
            switch result {
            case .success(let pins):
                let pin = pins.first { pin in
                    pin.latitude == annotation.coordinate.latitude && pin.longitude == annotation.coordinate.longitude
                }
                completion(.success(pin))
            case .failure(let error):
                print("Error fetching pins: \(error)")
                completion(.failure(error))
            }
        }
    }
}




