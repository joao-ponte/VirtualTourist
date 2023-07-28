//
//  TravelLocationViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import Foundation
import MapKit

final class TravelLocationViewModel {
    
    private let imageRepository: ImageRepositoryProtocol
    var pins: [Pin] = []
    private let dataControllerManager: DataControllerManager
    
    //injection of FlickrAPI in the viewModel, using default paramenter.
    init(dataControllerManager: DataControllerManager, imageRepository: ImageRepositoryProtocol = FlickrAPI() ) {
        
        self.dataControllerManager = dataControllerManager
        self.imageRepository = imageRepository
        loadPins()
    }
    
     func addPin(at coordinate: CLLocationCoordinate2D) {
        dataControllerManager.savePin(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        getImages(latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
            switch result {
            case .success(let imageUrls):
                for url in imageUrls {
                            print(url)
                        }
            case .failure(let error):
                print("Error fetching images: \(error)")
            }
        }
        
        loadPins()
    }
    
    private func loadPins() {
        pins = dataControllerManager.fetchPins()
    }
    
    func savePins() {
        dataControllerManager.savePins(pins)
    }
    
    func getImages(latitude: Double, longitude: Double, completion: @escaping (Result<[URL], Error>) -> Void) {
        imageRepository.getImages(latitude: latitude, longitude: longitude, pageNumber: 2) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let imageUrls = result {
                // At this point, you have an array of `URL` objects (imageUrls).
                // Do whatever you want with this array of URLs.
                // For example, you can use it to display images in your UI.
                completion(.success(imageUrls))
            } else {
                // If there are no images, you'll receive an empty array.
                // Handle this case as needed.
                completion(.success([]))
            }
        }
    }
}


