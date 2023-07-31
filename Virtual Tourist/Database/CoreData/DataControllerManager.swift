//
//  DataControllerManager.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import Foundation
import CoreData

class DataControllerManager: DataControllerProtocol {
    
    static let shared = DataControllerManager()
    
    private let dataController: CoreDataStack
    
    private init() {
        dataController = CoreDataStack(modelName: "VirtualTourist")
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
    
    func fetchPins() -> [Pin] {
        let fetchRequest: NSFetchRequest<Pin> = Pin.fetchRequest()
        
        do {
            return try dataController.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching pins: \(error)")
            return []
        }
    }
    
    func createPin(latitude: Double, longitude: Double) {
        let pin = Pin(context: dataController.viewContext)
        pin.latitude = latitude
        pin.longitude = longitude
        saveContext()
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
        let imageToDelete = getImages(for: id)
        
        imageToDelete?.forEach { image in
            dataController.viewContext.delete(image)
        }
        saveContext()
    }
    
    // MARK: - Image Management
    
    func createImage(for album: Album, blob: Data, imageUrl: String, id: Int64) {
        let newImage = Image(context: dataController.viewContext)
        newImage.blob = blob
        newImage.imageUrl = imageUrl
        newImage.id = id
        album.addToImages(newImage)
        saveContext()
    }
    
    func getImages(for albumID: UUID) -> [Image]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        fetchRequest.predicate = NSPredicate(format: "album.id == %@", albumID.uuidString)
        return try? dataController.viewContext.fetch(fetchRequest) as? [Image]
    }
    
    func deleteImage(_ image: Image) {
        dataController.viewContext.delete(image)
        saveContext()
    }
    
    func savePins(_ pins: [Pin]) {
        saveContext()
    }
    
    func load(completion: (() -> Void)? = nil) {
        dataController.load(completion: completion)
    }
    
    func saveImages(imageUrls: [URL], for pin: Pin) {
        let album = pin.album ?? createAlbum(for: pin)
        for imageUrl in imageUrls {
            let image = Image(context: dataController.viewContext)
            image.imageUrl = imageUrl.absoluteString
            image.album = album
        }
        saveContext()
    }
}

