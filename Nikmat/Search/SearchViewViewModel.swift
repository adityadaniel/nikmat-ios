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
  @Published var recipeList: [Recipe] = []
  @Published var searchText: String = ""

  init(service: APIService) {
    apiService = service
  }

  func searchRecipe() async {
    guard searchText.isNotEmpty else { return }
    do {
      let recipeResponse = try await apiService.GET(type: RecipeList.self, endpoint: .search(query: searchText))
      recipeList = recipeResponse.results
    } catch {
      print(error.localizedDescription)
    }
  }
}