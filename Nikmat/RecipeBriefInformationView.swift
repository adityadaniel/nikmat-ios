//
//  RecipeBriefInformationView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 16/06/21.
//

import SwiftUI

struct RecipeBriefInformationView: View {
  let recipe: Recipe
  
  var body: some View {
    HStack(spacing: 8) {
      HStack(spacing: 4) {
        Image(systemName: Icon.time)
          .foregroundColor(.primary)
        Text(recipe.times)
          .foregroundColor(.secondary)
      }
      
      HStack(spacing: 4) {
        Image(systemName: Icon.portion)
          .foregroundColor(.primary)
        Text(recipe.portion)
          .foregroundColor(.secondary)
      }
      
      HStack(spacing: 4) {
        Image(systemName: Icon.difficulty)
          .foregroundColor(.primary)
        Text(recipe.difficulty)
          .foregroundColor(.secondary)
      }
    }
    .font(.system(.footnote, design: .rounded))
  }
}

struct RecipeBriefInformationView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeBriefInformationView(recipe: .mock)
      .previewLayout(.fixed(width: 320, height: 50))
  }
}
