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
            Label("Resep", systemImage: "text.book.closed.fill")
              .foregroundColor(.primary)
          }
        FavoritesView()
          .tabItem {
            Label("Favorit", systemImage: "heart.fill")
              .foregroundColor(.primary)
          }
      }
      .accentColor(.primary)
    }
  }
}
