//
//  FavoritesView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 21/06/21.
//

import CoreData
import SwiftUI

struct FavoritesView: View {
  @FetchRequest(
    entity: SavedRecipe.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \SavedRecipe.createdAt, ascending: false)]
  ) var savedRecipes: FetchedResults<SavedRecipe>

  var recipes: [Recipe] {
    savedRecipes.map {
      Recipe(
        title: $0.title ?? "",
        thumb: $0.thumb ?? "",
        times: $0.times ?? "",
        key: $0.key ?? "",
        serving: $0.serving ?? "",
        difficulty: $0.difficulty ?? ""
      )
    }
  }

  var body: some View {
    NavigationView {
      Group {
        if recipes.isEmpty {
          Text("Resep favorit kamu kosong :(")
            .foregroundStyle(Color.secondary)
            .font(.caption)
        } else {
          List {
            ForEach(recipes) { recipe in
              SearchResultCell(recipe: recipe)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
          }
          .listStyle(.plain)
        }
      }
      .navigationTitle("Favorit")
    }
  }
}
