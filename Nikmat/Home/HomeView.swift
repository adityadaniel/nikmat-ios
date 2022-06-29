//
//  RecipesView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 14/06/21.
//

import SwiftUI

// update from homebiew

struct HomeView: View {
  @ObservedObject var viewModel: HomeViewModel

  var body: some View {
    NavigationView {
      GeometryReader { geo in
        ScrollView {
          ScrollableCategoryWidget(size: geo.size)

          FourImageWidgetView()

          VStack(alignment: .leading) {
            Text("Menu Terbaru")
              .font(.title2)
              .fontWeight(.semibold)

            if viewModel.isLoading {
              ProgressView()
                .frame(width: abs(geo.frame(in: CoordinateSpace.global).width - 32))
                .task {
                  await viewModel.recipeList()
                }
            } else {
              ForEach(viewModel.recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                  RecipeCell(recipe: recipe)
                }
              }
            }
          }
          .padding([.horizontal])
        }
        .navigationTitle("Resep")
        .listStyle(.plain)
        .refreshable {
          await viewModel.recipeList()
        }
      }
    }
  }
}

@MainActor
class HomeViewModel: ObservableObject {
  private let service: APIService
  private let storageProvider: StorageProvider

  @Published var isLoading: Bool = true
  @Published var recipes: [Recipe] = []

  init(service: APIService, storageProvider: StorageProvider) {
    self.service = service
    self.storageProvider = storageProvider
  }

  func recipeList() async {
    let savedRecipe = storageProvider.fetchAllSavedRecipe()

    do {
      let response = try await service.GET(type: RecipeList.self, endpoint: .featuredRecipes)
      recipes = response.results
      savedRecipe.forEach { saved in
        if let savedRecipeIndex = recipes.firstIndex(where: { $0.key == saved.key }) {
          recipes[savedRecipeIndex].isFavorite = true
        }
      }
      isLoading = false
    } catch {
      print(error.localizedDescription)
    }
  }

  func save(recipe: Recipe) {
    storageProvider.toggleSave(recipe: recipe)
  }
}
