//
//  RecipeDetailViewViewModel.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 23/06/21.
//

import SwiftUI

@MainActor
final class RecipeDetailViewViewModel: ObservableObject {
  @Published var recipeDetail: RecipeDetail? = nil

  private let service: APIService
  private let key: String

  init(service: APIService, key: String) {
    self.service = service
    self.key = key
  }

  func fetchRecipeDetail(key: String) async {
    do {
      let response = try await service.GET(
        type: RecipeDetailResponse.self,
        endpoint: .recipeDetail(key: key)
      )
      recipeDetail = response.results
    } catch {
      print(error.localizedDescription)
    }
  }
}
