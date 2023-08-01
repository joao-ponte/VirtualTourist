//
//  TravelLocationViewModel.swift
//  Virtual Tourist
//
//  Created by João Ponte on 19/07/2023.
//

import Foundation
import MapKit

protocol TravelLocationViewModelDelegate: AnyObject {
    func addAnnotation(_ annotation: MKPointAnnotation)
    func reloadMapAnnotations(_ annotations: [MKPointAnnotation])
}

final class TravelLocationViewModel {
    
    weak var delegate: TravelLocationViewModelDelegate?
    private let imageRepository: ImageRepositoryProtocol
    private let dataControllerManager: DataControllerProtocol
    
    // Injection of FlickrAPI in the viewModel, using default parameter.
    init(dataControllerManager: DataControllerProtocol, imageRepository: ImageRepositoryProtocol = FlickrAPI()) {
        self.dataControllerManager = dataControllerManager
        self.imageRepository = imageRepository
    }
    
    // Create a mutable array to hold the pins
    private var mutablePins: [MKPointAnnotation] = []
    
    // Expose the pins as a read-only property
    var pins: [MKPointAnnotation] {
        return mutablePins
    }
    
    private(set) var pinObjects: [Pin] = []
    
    
    func newAlbumAtLocation(at coordinate: CLLocationCoordinate2D) {
        // Create a new Pin object
        let newPin = dataControllerManager.createPin(latitude: coordinate.latitude, longitude: coordinate.longitude)
        pinObjects.append(newPin) // Add the actual Pin object to the pinObjects array
        
        // Fetch the images
        getImagesFromFlickr(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] result in
            switch result {
            case .success(let imageUrls):
                // Call the createAlbumWithImages method with the newPin and imageUrls
                self?.createAlbumWithImages(newPin, imageUrls: imageUrls)
            case .failure(let error):
                // Handle the error if needed
                print("Error fetching images: \(error)")
            }
        }
        
        // Update the pins array used for display on the map
        let newAnnotation = createAnnotation(for: coordinate)
        mutablePins.append(newAnnotation)
        delegate?.addAnnotation(newAnnotation)
    }
    
    private func createAlbumWithImages(_ pin: Pin, imageUrls: [URL]) {
        // Save the imageUrls to the data model (if needed).
        // For example, you can store them in the `Pin` model.
        // pin.imageUrls = imageUrls
        
        // Create an album
        let album = dataControllerManager.createAlbum(for: pin)
        
        // Save the image URLs to the album
        for imageUrl in imageUrls {
            dataControllerManager.createImage(for: album, imageUrl: imageUrl)
        }
        
        // Reload pins (if needed)
        loadPins()
    }
    
    private func loadPins() {
        mutablePins = pinObjects.map { pin in
            createAnnotation(for: CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude))
        }
        delegate?.reloadMapAnnotations(mutablePins)
    }
    
    func getImagesFromFlickr(latitude: Double, longitude: Double, completion: @escaping (Result<[URL], Error>) -> Void) {
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
    
    func createPhotoGalleryViewModel(for pin: Pin) -> PhotoGalleryViewModel? {
        return PhotoGalleryViewModel(dataControllerManager: dataControllerManager, pin: pin)
    }
    
    private func createAnnotation(for coordinate: CLLocationCoordinate2D) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        return annotation
    }
}
extension TravelLocationViewModel {
    
    func fetchSavedPins() {
        dataControllerManager.fetchPins { [weak self] result in
            switch result {
            case .success(let pins):
                self?.pinObjects = pins
                self?.loadPins() // Update the map with fetched pins
            case .failure(let error):
                // Handle the error if needed
                print("Error fetching pins: \(error)")
            }
        }
    }
}





