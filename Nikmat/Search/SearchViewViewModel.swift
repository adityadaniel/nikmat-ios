//
//  SearchViewViewModel.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 21/06/21.
//

import SwiftUI

@MainActor
class SearchViewViewModel: ObservableObject {
  private let apiService: APIService
  private let storageProvider: StorageProvider

  @Published var isSearching: Bool = false
  @Published var recipeList: [Recipe] = []
  @Published var searchText: String = ""

  init(service: APIService, storageProvider: StorageProvider) {
    apiService = service
    self.storageProvider = storageProvider
  }

  func searchRecipe() async {
    isSearching = true
    guard searchText.isNotEmpty else { return }
    do {
      let recipeResponse = try await apiService.GET(type: RecipeList.self, endpoint: .search(query: searchText))
      recipeList = recipeResponse.results
      isSearching = false
    } catch {
      print(error.localizedDescription)
    }
  }

  func saveRecipe(recipe: Recipe) {
    storageProvider.toggleSave(recipe: recipe)
  }
}
