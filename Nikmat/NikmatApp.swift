//
//  NikmatApp.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 14/06/21.
//

import SwiftUI

@main
struct NikmatApp: App {
  var body: some Scene {
    WindowGroup {
      TabView {
        RecipeListView()
          .tabItem {
            Label("Resep", systemImage: Icon.recipeTabIcon)
              .foregroundColor(.primary)
          }
        FavoritesView()
          .tabItem {
            Label("Favorit", systemImage: Icon.favoritesTabIcon)
              .foregroundColor(.primary)
          }
        SearchView()
          .tabItem {
            Label("Cari Resep", systemImage: Icon.searchTabIcon)
          }
      }
      .accentColor(.primary)
    }
  }
}
