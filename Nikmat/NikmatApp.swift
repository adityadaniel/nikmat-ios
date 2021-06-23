//
//  NikmatApp.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 14/06/21.
//

import SwiftUI

@main
struct NikmatApp: App {
  @StateObject private var storageProvider = StorageProvider(isInMemory: true)
  
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
        SearchView(viewModel: SearchViewViewModel(service: APIService.shared, storageProvider: storageProvider))
          .tabItem {
            Label("", systemImage: Icon.searchTabIcon)
          }
      }
      .accentColor(.primary)
      .environment(\.managedObjectContext, storageProvider.persistentContainer.viewContext)
      .environmentObject(storageProvider)
    }
  }
}
