//
//  ScrollableCategoryWidget.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 20/06/21.
//

import SwiftUI

struct ScrollableCategoryWidget: View {
  let categories: [Category] = Category.byIngredients
  let size: CGSize

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(categories) { category in
          NavigationLink(destination: RecipeListView(category: category)) {
            BigImageView(imageName: category.imageName, categoryName: category.name, width: size.width)
          }
        }
      }
    }
    .padding(.horizontal)
  }
}

struct ScrollableCategoryWidget_Previews: PreviewProvider {
  static var previews: some View {
    ScrollableCategoryWidget(size: .init(width: 320, height: 180))
  }
}

struct BigImageView: View {
  let imageName: String
  let categoryName: String
  let width: CGFloat

  var body: some View {
    VStack(alignment: .leading) {
      Image(imageName)
        .resizable()
        .scaledToFill()
        .frame(width: width * 0.8, height: 180)
        .cornerRadius(10)

      Text(categoryName)
        .font(.body)
        .fontWeight(.medium)
        .foregroundStyle(.black)
    }
  }
}
