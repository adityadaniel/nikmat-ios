//
//  RecipesView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 14/06/21.
//

import SwiftUI

struct RecipesView: View {
  @StateObject var viewModel = RecipeListViewModel(service: APIService.shared)
  
  var body: some View {
    NavigationView {
      if viewModel.isLoading {
        ProgressView()
          .navigationTitle("Recipes")
      } else {
        List {
          ForEach(viewModel.recipes) { recipe in
            RecipeCell(recipe: recipe)
              .listRowSeparator(.hidden)
          }
        }
        .navigationTitle("Recipes")
        .listStyle(.plain)
        .refreshable {
          await viewModel.recipeList()
        }
      }
    }
    .task {
      await viewModel.recipeList()
    }
  }
}

struct RecipesView_Previews: PreviewProvider {
  static var previews: some View {
    RecipesView()
  }
}

@MainActor
class RecipeListViewModel: ObservableObject {
  private let service: APIService
  
  @Published var isLoading: Bool = false
  @Published var recipes: [Recipe] = []
  
  init(service: APIService) {
    self.service = service
  }
  
  func recipeList() async {
    isLoading = true
    do {
      let response = try await service.GET(type: RecipeResponse.self, endpoint: .featuredRecipes)
      recipes = response.results
      isLoading = false
    } catch {
      print(error.localizedDescription)
    }
  }
}
