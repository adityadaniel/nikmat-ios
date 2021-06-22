//
//  Category.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 20/06/21.
//

import DeveloperToolsSupport
import Foundation

struct Category {
  let name: String
  let imageName: String
  let key: String
}

extension Category {
  static var allDayMenus: [Category] {
    return [
      Category(name: "Sarapan", imageName: "sarapan", key: "sarapan"),
      Category(name: "Menu\nMakan Siang", imageName: "menu-makan-siang", key: "makan-siang"),
      Category(name: "Menu\nMakan Malam", imageName: "menu-makan-malam", key: "makan-malam"),
      Category(name: "Dessert", imageName: "dessert", key: "resep-dessert"),
    ]
  }

  static var byIngredients: [Category] {
    return [
      .init(name: "Resep Ayam", imageName: "resep-ayam", key: "resep-ayam"),
      .init(name: "Resep Daging", imageName: "resep-daging", key: "resep-daging"),
      .init(name: "Resep Sayuran", imageName: "resep-sayuran", key: "resep-sayuran"),
      .init(name: "Resep Seafood", imageName: "resep-seafood", key: "resep-seafood"),
    ]
  }
}

extension Category: Identifiable {
  var id: String {
    return "\(name) - \(imageName)"
  }
}
