//
//  DataControllerManager.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import Foundation
import CoreData

class DataControllerManager {
    static let shared = DataControllerManager()
    
    private let dataController: DataController
    
    private init() {
        dataController = DataController(modelName: "VirtualTourist")
    }
    
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
    
    func savePin(latitude: Double, longitude: Double) {
        let pin = Pin(context: dataController.viewContext)
        pin.latitude = latitude
        pin.longitude = longitude
        saveContext()
    }
    
    func load(completion: (() -> Void)? = nil) {
        dataController.load(completion: completion)
    }
}


