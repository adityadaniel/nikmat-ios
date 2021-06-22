//
//  RecipeListView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 22/06/21.
//

import SwiftUI

struct RecipeListView: View {
  @StateObject var viewModel: RecipeListViewModel

  let category: Category

  init(category: Category) {
    self.category = category
    _viewModel = StateObject(wrappedValue: RecipeListViewModel(service: APIService.shared, category: category))
  }

  var body: some View {
    Group {
      if viewModel.isLoading {
        ProgressView()
      } else {
        List {
          ForEach(viewModel.recipes) { recipe in
            RecipeCell(recipe: recipe)
              .listRowSeparator(.hidden)
          }
        }
        .refreshable {
          await viewModel.fetchRecipe()
        }
        .listStyle(.plain)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .navigationTitle(category.name)
    .task {
      await viewModel.fetchRecipe()
    }
  }
}

struct RecipeListView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListView(category: .allDayMenus[0])
  }
}

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
    do {
      let response = try await service.GET(type: RecipeList.self, endpoint: .recipeByCategory(category: category.key))
      recipes = response.results
      isLoading = false
    } catch {
      print(error.localizedDescription)
    }
  }
}
