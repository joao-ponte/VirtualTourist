//
//  DataController.swift
//  Virtual Tourist
//
//  Created by João Ponte on 20/07/2023.
//

import CoreData

struct CoreDataStack {

    static let context = persistentContainer.viewContext

    private static let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "VirtualTourist")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
