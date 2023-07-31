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
        dataControllerManager.createPin(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        // Fetch the images
        getImages(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] result in
            switch result {
            case .success(let imageUrls):
                // Call the addPin method with the imageUrls
                self?.addPin(at: coordinate, imageUrls: imageUrls)
            case .failure(let error):
                // Handle the error if needed
                print("Error fetching images: \(error)")
            }
        }
        
        loadPins()
    }
    
    private func addPin(at coordinate: CLLocationCoordinate2D, imageUrls: [URL]) {
        // Save the imageUrls to the data model (if needed).
        // For example, you can store them in the `Pin` model.
        // pin.imageUrls = imageUrls
        
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


