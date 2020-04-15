//
//  CoreDataManager.swift
//  Quote of the Day
//
//  Created by Benjamin Musoke-Lubega on 4/11/20.
//  Copyright © 2020 Ben Musoke-Lubega. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
	
	private override init() {}
	
	static var managedObjectContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	static var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Quote of the Day")
		
		container.loadPersistentStores { description, error in
			if let error = error {
				fatalError("Unable to load persistent stores: \(error)")
			}
		}
		return container
	}()
	
	static func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
				print("SAVED")
			} catch let error as NSError {
				print("Could not save. \(error), \(error.userInfo)")
				
			}
		}
	}
}
