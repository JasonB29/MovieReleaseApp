//
//  TestCoreDataStack.swift
//  ReleaseDatesAppTests
//
//  Created by Jason Bannister on 14/09/2021.
//

import CoreData
import MovieReleaseDateApp

class TestCoreDataStack: NSObject {
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
    
    let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: "ReleaseDatesApp", managedObjectModel: self.managedObjectModel)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores {_, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
        
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))])!
        return managedObjectModel
    }()
    
}
