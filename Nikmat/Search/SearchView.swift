//
//  SearchView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 21/06/21.
//

import SwiftUI

struct SearchView: View {
  @StateObject var viewModel = SearchViewViewModel(service: APIService.shared)

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.recipeList) { recipe in
          SearchResultCell(recipe: recipe)
            .swipeActions(allowsFullSwipe: true) {
              Button {
                print("mark as favorites")
              } label: {
                Label("Simpan ke favorit", systemImage: Icon.heart)
              }
            }
            .tint(.primary)
        }
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
      .searchable("Soto ayam", text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
      .onSubmit(of: .search) {
        async {
          await viewModel.searchRecipe()
        }
      }
      .navigationTitle("Cari Resep")
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}
