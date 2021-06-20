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
          VStack(alignment: .leading) {
            Image(category.imageName)
              .resizable()
              .scaledToFill()
              .frame(width: size.width * 0.8, height: 180)
              .cornerRadius(10)
            
            Text(category.name)
              .font(.body)
              .fontWeight(.medium)
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
