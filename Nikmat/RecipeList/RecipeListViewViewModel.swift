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

  init(service: APIService, category: Category) {
    self.service = service
    self.category = category
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
}
