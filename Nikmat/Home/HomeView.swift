//
//  RecipesView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 14/06/21.
//

import SwiftUI

struct HomeView: View {
  @StateObject var viewModel = HomeViewModel(service: APIService.shared)

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

struct RecipesView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

@MainActor
class HomeViewModel: ObservableObject {
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
