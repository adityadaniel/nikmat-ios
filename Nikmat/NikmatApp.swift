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
                RecipesView()
                    .tabItem {
                        Label("Recipes", systemImage: "text.book.closed.fill")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }
            }
        }
    }
}
