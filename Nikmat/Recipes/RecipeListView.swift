//
//  RecipesView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 14/06/21.
//

import SwiftUI

struct RecipeListView: View {
  @StateObject var viewModel = RecipeListViewModel(service: APIService.shared)

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
                .frame(width: geo.size.width)
                .task {
                  await viewModel.recipeList()
                }
            } else {
              ForEach(viewModel.recipes) { recipe in
                RecipeCell(recipe: recipe)
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

struct RecipesView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListView()
  }
}

@MainActor
class RecipeListViewModel: ObservableObject {
  private let service: APIService

  @Published var isLoading: Bool = true
  @Published var recipes: [Recipe] = []

  init(service: APIService) {
    self.service = service
  }

  func recipeList() async {
    do {
      let response = try await service.GET(type: RecipeList.self, endpoint: .featuredRecipes)
      recipes = response.results
      isLoading = false
    } catch {
      print(error.localizedDescription)
    }
  }
}
