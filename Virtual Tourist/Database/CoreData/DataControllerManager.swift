//
//  DataControllerManager.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import Foundation
import CoreData

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
    
    func deleteImages(for album: Album) {
        guard let id = album.id else { return }
        let imagesToDelete = getImages(for: id) ?? []
        
        for image in imagesToDelete {
            dataController.viewContext.delete(image)
        }
        
        saveContext()
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
    
    func getImages(for albumID: UUID) -> [Image]? {
        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
        fetchRequest.predicate = NSPredicate(format: "album.id == %@", albumID as CVarArg)
        
        do {
            return try dataController.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching images: \(error)")
            return nil
        }
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


