//
//  RecipeCell.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 15/06/21.
//

import SDWebImage
import SDWebImageSwiftUI
import SwiftUI

struct RecipeCell: View {
  let recipe: Recipe

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10, style: .continuous)
        .fill(.white)
        .shadow(color: .secondary.opacity(0.4), radius: 1.8)

      VStack(alignment: .leading, spacing: 8) {
        ZStack(alignment: .topTrailing) {
          WebImage(url: URL(string: recipe.thumb))
            .resizable()
            .placeholder(Image(systemName: "photo"))
            .indicator(.activity)
            .scaledToFit()
            .frame(minWidth: 250, minHeight: 80)

          Image(systemName: Icon.heart)
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundColor(.primary)
            .background(
              Circle()
                .frame(width: 32, height: 32)
                .foregroundColor(.white)
            )
            .padding([.trailing, .top], 16)
        }

        VStack(alignment: .leading, spacing: 8) {
          Text(recipe.title)
            .foregroundColor(.black)
            .font(.body)
            .fontWeight(.medium)

          RecipeBriefInformationView(recipe: recipe)
        }
        .padding([.leading, .trailing], 8)
      }
      .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
      .shadow(color: .gray.opacity(0.4), radius: 4)
      .padding(.bottom)
    }
  }
}

struct RecipeCell_Previews: PreviewProvider {
  static var previews: some View {
    RecipeCell(recipe: .mock)
      .previewLayout(.sizeThatFits)
  }
}
