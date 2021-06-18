//
//  RecipeResponse.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 15/06/21.
//

import Foundation

struct RecipeResponse {
  let method: String
  let status: Bool
  let results: [Recipe]
}

extension RecipeResponse: Decodable {}

struct Recipe {
  let title: String
  let thumb: String
  let times: String
  let key: String
  let portion: String
  let difficulty: String
}

extension Recipe {
  internal static var mock: Self {
    Recipe(
      title: "Resep Asem-Asem Daging Legendaris, Makanan Khas dari Kota Semarang",
      thumb: "https://www.masakapahariini.com/wp-content/uploads/2021/06/asem-asem-daging-dish-400x240.jpg",
      times: "30mnt",
      key: "resep-asem-asem-daging",
      portion: "4 porsi",
      difficulty: "Mudah"
    )
  }
}


extension Recipe: Identifiable {
  var id: String {
    return key
  }
}
extension Recipe: Decodable {}