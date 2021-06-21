//
//  SearchResultCell.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 21/06/21.
//

import SwiftUI

struct SearchResultCell: View {
  let recipe: Recipe

  var body: some View {
    HStack(alignment: .top) {
      AsyncImage(url: URL(string: recipe.thumb)) { img in
        img
          .resizable()
          .scaledToFill()
          .frame(width: 120, height: 80)
          .cornerRadius(10)

      } placeholder: {
        Rectangle()
          .foregroundColor(.grayA68)
          .redacted(reason: .placeholder)
          .frame(width: 120, height: 80)
          .cornerRadius(10)
      }

      VStack(alignment: .leading, spacing: 8) {
        Text(recipe.title)
          .font(.footnote)
      }
    }
  }
}

struct SearchResultCell_Previews: PreviewProvider {
  static var previews: some View {
    SearchResultCell(recipe: .mock)
      .previewLayout(.sizeThatFits)
  }
}
