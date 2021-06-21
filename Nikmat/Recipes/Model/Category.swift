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
}

extension Category {
  static var allDayMenus: [Category] {
    return [
      Category(name: "Sarapan", imageName: "sarapan"),
      Category(name: "Menu\nMakan Siang", imageName: "menu-makan-siang"),
      Category(name: "Menu\nMakan Malam", imageName: "menu-makan-malam"),
      Category(name: "Dessert", imageName: "dessert"),
    ]
  }

  static var byIngredients: [Category] {
    return [
      .init(name: "Resep Ayam", imageName: "resep-ayam"),
      .init(name: "Resep Daging", imageName: "resep-daging"),
      .init(name: "Resep Sayuran", imageName: "resep-sayuran"),
      .init(name: "Resep Seafood", imageName: "resep-seafood"),
    ]
  }
}

extension Category: Identifiable {
  var id: String {
    return "\(name) - \(imageName)"
  }
}
