//
//  MenuWidgetView.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 18/06/21.
//

import SwiftUI

struct MenuWidgetView: View {
  let gridItems = [
    GridItem(.flexible(), spacing: 4),
    GridItem(.flexible(), spacing: 4),
  ]

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("Menu Pilihan")
        .font(.title2)
        .fontWeight(.semibold)
      LazyVGrid(columns: gridItems, spacing: 4) {
        MenuImageView(imageName: "rica-rica-bebek", title: "Menu\nMakan Malam")
        MenuImageView(imageName: "dessert", title: "Menu\nMakan Malam")
        MenuImageView(imageName: "dessert", title: "Menu\nMakan Malam")
        MenuImageView(imageName: "dessert", title: "Menu\nMakan Malam")
      }
    }
    .padding()
  }
}

struct MenuWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    MenuWidgetView()
      .previewLayout(.sizeThatFits)
  }
}

struct MenuImageView: View {
  let imageName: String
  let title: String

  var body: some View {
    Image(imageName)
      .resizable()
      .scaledToFill()
      .frame(minWidth: 150)
      .overlay(
        Rectangle()
          .foregroundColor(.clear)
          .background(LinearGradient(colors: [Color.black.opacity(0.7), Color.clear], startPoint: .bottom, endPoint: .top))
          .frame(maxHeight: 70)
        ,
        alignment: .bottom
      )
      .overlay(
        Text(title)
          .foregroundColor(.white)
          .font(.title3)
          .fontWeight(.semibold)
          .padding(8)
        ,
        alignment: .bottomLeading
      )
      .cornerRadius(10)
  }
}
