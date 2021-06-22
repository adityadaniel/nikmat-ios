//
//  RecipeListView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 22/06/21.
//

import SwiftUI

struct RecipeListView: View {
  let category: Category

  var body: some View {
    Text(category.name)
      .navigationTitle(category.name)
  }
}

struct RecipeListView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListView(category: .allDayMenus[0])
  }
}
