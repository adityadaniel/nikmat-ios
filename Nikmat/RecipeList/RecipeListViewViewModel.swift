//
//  RecipeListViewViewModel.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 23/06/21.
//

import SwiftUI

@MainActor
final class RecipeListViewModel: ObservableObject {
  @Published var recipes: [Recipe] = []
  @Published var isLoading: Bool = true

  private let service: APIService
  private let category: Category
  private let storageProvider: StorageProvider

  init(service: APIService, category: Category, storageProvider: StorageProvider) {
    self.service = service
    self.category = category
    self.storageProvider = storageProvider
  }

  func fetchRecipe() async {
    guard recipes.isEmpty else { return }
    do {
      let response = try await service.GET(type: RecipeList.self, endpoint: .recipeByCategory(category: category.key))
      recipes = response.results
      isLoading = false
    } catch {
      print(error.localizedDescription)
    }
  }

  func saveFavoriteRecipe(recipe: Recipe) {
    storageProvider.toggleSave(recipe: recipe)
  }
}
