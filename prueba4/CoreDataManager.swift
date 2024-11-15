//
//  CoreDataManager.swift
//  prueba4
//
//  Created by Cristian Gaytan on 15/11/24.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager() // Singleton para acceder a Core Data
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model") // Nombre del archivo .xcdatamodeld
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error al cargar el almacén persistente: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

