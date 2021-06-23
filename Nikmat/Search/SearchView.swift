//
//  SearchView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 21/06/21.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var viewModel: SearchViewViewModel

  var body: some View {
    NavigationView {
      Group {
        if viewModel.isSearching {
          VStack(spacing: 12) {
            ProgressView()

            Text("Mencari...")
              .font(.footnote)
              .foregroundColor(.grayA68)
          }
        } else {
          List {
            ForEach(viewModel.recipeList) { recipe in
              NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                SearchResultCell(recipe: recipe)
              }
              .swipeActions(allowsFullSwipe: true) {
                Button {
                  viewModel.saveRecipe(recipe: recipe)
                } label: {
                  Label("Simpan ke favorit", systemImage: Icon.heart)
                }
              }
              .tint(.primary)
            }
            .listRowSeparator(.hidden)
          }
        }
      }
      .onChange(of: viewModel.searchText, perform: { newValue in
        if newValue.isEmpty { viewModel.recipeList.removeAll() }
      })
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
