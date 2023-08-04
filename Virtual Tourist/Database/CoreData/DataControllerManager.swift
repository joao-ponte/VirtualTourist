//
//  DataControllerManager.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import Foundation
import CoreData
import MapKit

class DataControllerManager: DataControllerProtocol {
    
    private let dataController: CoreDataStack
    
    init(modelName: String) {
        dataController = CoreDataStack(modelName: modelName)
        dataController.load()
    }
    
    // MARK: - Pin Management
    
    func saveContext() {
        if dataController.viewContext.hasChanges {
            do {
                try dataController.viewContext.save()
            } catch {
                fatalError("Error saving context: \(error)")
            }
        }
    }
    
    func getPin(for annotation: MKAnnotation, completion: @escaping (Result<Pin?, Error>) -> Void) {
        // Fetch pins based on the annotation's coordinates
        fetchPins { result in
            switch result {
            case .success(let pins):
                let pin = pins.first { pin in
                    pin.latitude == annotation.coordinate.latitude &&
                    pin.longitude == annotation.coordinate.longitude
                }
                completion(.success(pin))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPins(completion: @escaping (Result<[Pin], Error>) -> Void) {
        do {
            let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
            let pins = try dataController.viewContext.fetch(fetchRequest)
            completion(.success(pins))
        } catch {
            completion(.failure(error))
        }
    }

    
    func createPin(latitude: Double, longitude: Double) -> Pin {
        let newPin = Pin(context: dataController.viewContext)
        newPin.latitude = latitude
        newPin.longitude = longitude
        saveContext()
        return newPin
    }
    
    // MARK: - Album Management
    
    func createAlbum(for pin: Pin) -> Album {
        let album = Album(context: dataController.viewContext)
        album.id = UUID()
        album.pin = pin
        saveContext()
        return album
    }
    
    func fetchAlbums() -> Result<[Album], Error> {
        do {
            let fetchRequest: NSFetchRequest<Album> = Album.fetchRequest()
            let albums = try dataController.viewContext.fetch(fetchRequest)
            return .success(albums)
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - Image Management
    
    func createImage(for album: Album, imageUrl: URL) {
        let newImage = Image(context: dataController.viewContext)
        newImage.imageUrl = imageUrl.absoluteString
        newImage.album = album
        saveContext()
    }
    
    func fetchImages() -> Result<[Image], Error> {
        do {
            let fetchRequest: NSFetchRequest<Image> = Image.fetchRequest()
            let images = try dataController.viewContext.fetch(fetchRequest)
            return .success(images)
        } catch {
            return .failure(error)
        }
    }
    
    func deleteImage(_ image: Image) {
        dataController.viewContext.delete(image)
        saveContext()
    }
    
    func saveImages(imageUrls: [URL], for pin: Pin) {
        let album = pin.album ?? createAlbum(for: pin)
        for imageUrl in imageUrls {
            createImage(for: album, imageUrl: imageUrl)
        }
        saveContext()
    }
    
    func load(completion: (() -> Void)?) {
        dataController.load {
            completion?()
        }
    }
}


