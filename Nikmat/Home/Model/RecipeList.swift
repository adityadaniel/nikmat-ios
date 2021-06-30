//
//  RecipeResponse.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 15/06/21.
//

import Foundation

struct RecipeList {
  let method: String
  let status: Bool
  var results: [Recipe]
}

extension RecipeList: Decodable {}

struct Recipe {
  let title: String
  let thumb: String
  let times: String
  let key: String
  let serving: String
  let difficulty: String
  var isFavorite: Bool = false

  internal init(title: String, thumb: String, times: String, key: String, serving: String, difficulty: String) {
    self.title = title
    self.thumb = thumb
    self.times = times
    self.key = key
    self.serving = serving
    self.difficulty = difficulty
  }
}

extension Recipe {
  static var mock: Self {
    Recipe(
      title: "Resep Asem-Asem Daging Legendaris, Makanan Khas dari Kota Semarang",
      thumb: "https://www.masakapahariini.com/wp-content/uploads/2021/06/asem-asem-daging-dish-400x240.jpg",
      times: "30mnt",
      key: "resep-asem-asem-daging",
      serving: "4 porsi",
      difficulty: "Mudah"
    )
  }
}

extension Recipe: Identifiable {
  var id: String {
    return key
  }
}

extension Recipe: Decodable {
  private enum CodingKeys: String, CodingKey {
    case title
    case thumb
    case times
    case key
    case serving
    case difficulty
    case isFavorite
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    thumb = try container.decode(String.self, forKey: .thumb)
    times = try container.decode(String.self, forKey: .times)
    key = try container.decode(String.self, forKey: .key)
    serving = try container.decode(String.self, forKey: .serving)
    difficulty = try container.decode(String.self, forKey: .difficulty)
    isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
  }
}
