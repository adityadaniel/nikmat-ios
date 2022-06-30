//
//  NikmatApp.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 14/06/21.
//

import SwiftUI

// Try stackedDiff workflow, this is new changes and this is after code review:
// address code review
@main
struct NikmatApp: App {
  @StateObject private var dataController = StorageProvider.shared

  var body: some Scene {
    WindowGroup {
      TabView {
        HomeView(
          viewModel: HomeViewModel(
            service: APIService.shared,
            storageProvider: StorageProvider.shared
          )
        ).tabItem {
          Label("", systemImage: Icon.recipeTabIcon)
        }

        FavoritesView()
          .tabItem {
            Label("", systemImage: Icon.favoritesTabIcon)
          }

        SearchView(
          viewModel: SearchViewViewModel(
            service: APIService.shared,
            storageProvider: StorageProvider.shared
          )
        ).tabItem {
          Label("", systemImage: Icon.searchTabIcon)
        }
      }
      .accentColor(.primary)
      .environment(\.managedObjectContext, dataController.persistentContainer.viewContext)
      .environmentObject(dataController)
    }
  }
}
