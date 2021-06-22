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
        HomeView()
          .tabItem {
            Label("", systemImage: Icon.recipeTabIcon)
          }
        FavoritesView()
          .tabItem {
            Label("", systemImage: Icon.favoritesTabIcon)
          }
        SearchView()
          .tabItem {
            Label("", systemImage: Icon.searchTabIcon)
          }
      }
      .accentColor(.primary)
    }
  }
}
