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
        ScrollView {
          ForEach(viewModel.recipes) { recipe in
            VStack {
              NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                RecipeCell(recipe: recipe)
              }
            }
            .padding([.horizontal])
          }
        }
        .refreshable {
          await viewModel.fetchRecipe()
        }
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
