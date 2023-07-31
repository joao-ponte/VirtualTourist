//
//  DataController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import CoreData

struct CoreDataStack {
    
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



