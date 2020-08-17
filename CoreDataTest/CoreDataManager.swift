//
//  CoreDataManager.swift
//  CoreDataTest
//
//  Created by Gor on 5/14/20.
//  Copyright © 2020 user1. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getNotes() -> [Note] {
        let request = NSFetchRequest<Note>(entityName: "Note")
        if let notes = try? context.fetch(request) {
            return notes
        }
        return []
    }
    
    func saveNote(title: String) -> Note {
        let note = Note.setUp(for: context)
        note.title = title
        saveContext()
        return note
    }
    
    // MARK: - Core Data SetUp

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

private extension Note {
    class func setUp(for context: NSManagedObjectContext) -> Note {
        let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: context)!
        let note = NSManagedObject(entity: noteEntity, insertInto: context) as! Note
        return note
    }
}
