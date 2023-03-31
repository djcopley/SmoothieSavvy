//
//  DataController.swift
//  SmoothieSavvy
//
//  Created by Daniel Copley on 3/25/23.
//

import CoreData

struct PersistenceController {
    // MARK: - Persistence Init
    
    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "SmoothieSavvy")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    // MARK: - Interact methods
    
    func childViewContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = container.viewContext
        return context
    }
    
    func newTemporaryInstance<T: NSManagedObject>(in context: NSManagedObjectContext) -> T {
        return T(context: context)
    }
    
    func copyForEditing<T: NSManagedObject>(of object: T, in context: NSManagedObjectContext) -> T {
        guard let object = (try? context.existingObject(with: object.objectID)) as? T else {
            fatalError("Requested a copy of a managed object that does not exist")
        }
        return object
    }
    
    func persist(_ object: NSManagedObject) {
        try! object.managedObjectContext?.save()
        if let parent = object.managedObjectContext?.parent {
            try! parent.save()
        }
    }

    func save() {
        do {
            try container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    // MARK: - Shared Controller
    
    static let shared = PersistenceController()
}
