//
//  DataController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import Foundation
import CoreData

class DataController {
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("Failed to load store: \(error!)")
            }
            completion?()
        }
    }
}



