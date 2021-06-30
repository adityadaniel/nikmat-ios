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
    _viewModel = StateObject(
      wrappedValue: RecipeListViewModel(
        service: APIService.shared,
        category: category,
        storageProvider: StorageProvider.shared
      )
    )
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
