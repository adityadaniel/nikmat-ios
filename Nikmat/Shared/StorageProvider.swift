//
//  StorageProvider.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 23/06/21.
//

import CoreData

final class StorageProvider: ObservableObject {
  let persistentContainer: NSPersistentContainer

  init(isInMemory: Bool) {
    persistentContainer = NSPersistentContainer(name: "Main")
    
    if isInMemory {
      persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    
    persistentContainer.loadPersistentStores { _, error in
      if let error = error {
        print("Failed to load persistent store: \(error.localizedDescription)")
      }
    }
  }
  
  private func save() {
    if persistentContainer.viewContext.hasChanges {
      do {
        try persistentContainer.viewContext.save()
        print("Succesfully save")
      } catch {
        persistentContainer.viewContext.rollback()
        print("Failed to save: \(error.localizedDescription)")
      }
    }
  }
  
  func fetchRequest() -> NSFetchRequest<SavedRecipe> {
    let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(keyPath: \SavedRecipe.createdAt, ascending: false)
    ]
    
    return request
  }
  
  func fetchAllSavedRecipe() -> [Recipe] {
    let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(keyPath: \SavedRecipe.createdAt, ascending: false)
    ]
    
    let fetchedResultController: NSFetchedResultsController<SavedRecipe> = NSFetchedResultsController(
      fetchRequest: request,
      managedObjectContext: persistentContainer.viewContext,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
    
    do {
      try fetchedResultController.performFetch()
    } catch {
      print("Failed fetching from Core Data: \(error.localizedDescription)")
    }
    
    if let savedRecipe = fetchedResultController.fetchedObjects {
      return savedRecipe.map {
        return Recipe(
          title: $0.title ?? "",
          thumb: $0.thumb ?? "",
          times: $0.times ?? "",
          key: $0.key ?? "",
          serving: $0.serving ?? "",
          difficulty: $0.difficulty ?? ""
        )
      }
    } else {
      return []
    }
  }
  
  func toggleSave(recipe: Recipe) {
    let fetchRequest = SavedRecipe.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "%K = %@", #keyPath(SavedRecipe.key), recipe.key)
    fetchRequest.fetchLimit = 1

    let matchingItems = try? persistentContainer.viewContext.fetch(fetchRequest)
    
    if let item = matchingItems?.first {
      persistentContainer.viewContext.delete(item)
    } else {
      let savedRecipe = SavedRecipe(context: persistentContainer.viewContext)
      savedRecipe.title = recipe.title
      savedRecipe.thumb = recipe.thumb
      savedRecipe.times = recipe.times
      savedRecipe.key = recipe.key
      savedRecipe.serving = recipe.key
      savedRecipe.difficulty = recipe.key
      savedRecipe.createdAt = Date()
    }
    
    save()
  }
}
