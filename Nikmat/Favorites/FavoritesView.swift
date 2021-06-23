//
//  FavoritesView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 21/06/21.
//

import SwiftUI
import CoreData

struct FavoritesView: View {
  
  @FetchRequest(
    entity: SavedRecipe.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \SavedRecipe.createdAt, ascending: false)]) var savedRecipes: FetchedResults<SavedRecipe>

  
  var recipes: [Recipe] {
    savedRecipes.map {
      Recipe(
        title: $0.title ?? "",
        thumb: $0.thumb ?? "",
        times: $0.times ?? "",
        key: $0.key ?? "",
        serving: $0.serving ?? "",
        difficulty: $0.difficulty ?? ""
      )
    }
  }
  
  
  var body: some View {
    NavigationView {
      Group {
        if recipes.isEmpty {
          Text("Resep favorit kamu kosong :(")
            .foregroundStyle(Color.secondary)
            .font(.caption)
        } else {
          List {
            ForEach(recipes) { recipe in
              SearchResultCell(recipe: recipe)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
          }
          .listStyle(.plain)
        }
      }
      .navigationTitle("Favorit")
    }
  }
}

//class FavoritesViewViewModel: ObservableObject {
//
//  @Published var recipes: [Recipe] = []
//
//  private let fetchedResults: FetchedResults<SavedRecipe>
//
//  init(savedRecipes: FetchedResults<SavedRecipe>) {
//    self.fetchedResults = savedRecipes
//  }
//
//  func fetchSavedRecipes() {
//    recipes = fetchedResults.map {
//      Recipe(
//        title: $0.title ?? "",
//        thumb: $0.thumb ?? "",
//        times: $0.times ?? "",
//        key: $0.key ?? "",
//        serving: $0.serving ?? "",
//        difficulty: $0.difficulty ?? ""
//      )
//    }
//  }
  
//  @Published var recipes: [Recipe] = []
//
//  private let fetchedResultsController: NSFetchedResultsController<SavedRecipe>
//  private let storageProvider: StorageProvider
//
//  init() {
//    self.storageProvider = storageProvider
//    fetchedResultsController = NSFetchedResultsController(
//      fetchRequest: storageProvider.fetchRequest(),
//      managedObjectContext: storageProvider.persistentContainer.viewContext,
//      sectionNameKeyPath: nil,
//      cacheName: nil
//    )
//    super.init()
//    fetchedResultsController.delegate = self
//    recipes = fetchedResultsController.fetchedObjects?.compactMap {
//      Recipe(
//        title: $0.title ?? "",
//        thumb: $0.thumb ?? "",
//        times: $0.times ?? "",
//        key: $0.key ?? "",
//        serving: $0.serving ?? "",
//        difficulty: $0.difficulty ?? ""
//      )
//    } ?? []
//  }
  
//  func fetchSavedRecipe() {
    
//    recipes = storageProvider.fetchAllSavedRecipe()
    
    
//    recipes = savedRecipes.map {
//      Recipe(
//        title: $0.title ?? "",
//        thumb: $0.thumb ?? "",
//        times: $0.times ?? "",
//        key: $0.key ?? "",
//        serving: $0.serving ?? "",
//        difficulty: $0.difficulty ?? ""
//      )
//    }
//  }
//}

//extension FavoritesViewViewModel: NSFetchedResultsControllerDelegate {
//  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    let savedRecipes = controller.fetchedObjects as? [Recipe]
//
//    recipes = savedRecipes?
//      .compactMap {
//        Recipe(
//          title: $0.title ,
//          thumb: $0.thumb ,
//          times: $0.times ,
//          key: $0.key ,
//          serving: $0.serving ,
//          difficulty: $0.difficulty
//        )
//      } ?? []
//  }
//}
