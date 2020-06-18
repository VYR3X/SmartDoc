//
//  DataStoreManager.swift
//  Smart Doc
//
//  Created by Vlad Zhokhov on 14/06/2020.
//  Copyright © 2020 Vlad Zhokhov. All rights reserved.
//

import Foundation
import CoreData

/// Менеджер хранения данных в Core Data
final class DataStoreManager {

	/// Массив талонов на прием к врачу
	private var tickets: [Ticket] = []

	/// Контекст данных
	private lazy var viewContext: NSManagedObjectContext = {
		return persistentContainer.viewContext
	}()

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
		/*
		 The persistent container for the application. This implementation
		 creates and returns a container, having loaded the store for the
		 application to it. This property is optional since there are legitimate
		 error conditions that could cause the creation of the store to fail.
		*/
		let container = NSPersistentContainer(name: "SlotCoreData")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

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
		return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}

	/// Добавить новый талон на запиcь и сохранить в Core Data
	func setTicketToCoreData(dates: [String], specialization: [String], polyclinicNames: [String]) {

		//As we know that container is set up in the AppDelegates so we need to refer that container.
		// guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

		//We need to create a context from this container
		let managedContext = persistentContainer.viewContext

		//Now let’s create an entity and new user records.
		let userEntity = NSEntityDescription.entity(forEntityName: "Ticket", in: managedContext)!

		//final, we need to add some data to our newly created record for each keys using
		//here adding 5 data with loop
		var index = 0
		for date in dates {
			let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
			user.setValue("\(date)", forKeyPath: "date")
			user.setValue("\(polyclinicNames[index])", forKey: "polyclinic")
			user.setValue("\(specialization[index])", forKey: "specialitie")
			index += 1
		}

		//Now we have set all the values. The next step is to save them inside the Core Data

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}

	/// Получить талоны на прием к врачу из Соre Data
	func fetchTicketsFromCoreData() -> [Ticket] {

		//As we know that container is set up in the AppDelegates so we need to refer that container.
		//guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

		//We need to create a context from this container
		let managedContext = persistentContainer.viewContext

		//Prepare the request of type NSFetchRequest  for the entity
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket")

		do {
			let result = try managedContext.fetch(fetchRequest)
			tickets = result as! [Ticket]
			for data in result as! [NSManagedObject] {
				print(data.value(forKey: "date") as! String)
				print(data.value(forKey: "specialitie") as! String)
				print(data.value(forKey: "polyclinic") as! String)
			}
		} catch {
			print("Failed")
		}
		return tickets
	}

	/// Удалить талоны на прием к врачу из Соre Data
	func deleteData() {

		//As we know that container is set up in the AppDelegates so we need to refer that container.
		//guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

		//We need to create a context from this container
		let managedContext = persistentContainer.viewContext

		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket")
		//fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
		do {
			let test = try managedContext.fetch(fetchRequest)

			let objectToDelete = test[0] as! NSManagedObject
			managedContext.delete(objectToDelete)
			do {
				try managedContext.save()
			}
			catch { print(error) }
		} catch { print(error) }
	}
}
