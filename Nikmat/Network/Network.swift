//
//  Network.swift
//  Nikmat
//
//  Created by Daniel Aditya Istyana on 16/06/21.
//

import Foundation
import UserNotifications

final class APIService {
  
  static let shared = APIService()
  private let baseUrl = URL(string: "https://masakapahariini.vercel.app/api/")!
  
  internal enum Endpoint {
    case featuredRecipes
    case featuredArticles
    case recipeDetail(key: String)
    
    func path() -> String {
      switch self {
      case .featuredRecipes:
        return "recipes"
      case .featuredArticles:
        return "featured/articles"
      case .recipeDetail(key: let key):
        return "recipes/\(key)"
      }
    }
  }
  
  internal enum APIError: Swift.Error {
    case invalidUrl
    case serverError
    case decodingError
    case networkError
    case notFound
  }
  
  func GET<T: Decodable>(
    type: T.Type = T.self,
    endpoint: Endpoint,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
  ) async throws -> T {
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = keyDecodingStrategy
    
    let url = baseUrl.appendingPathComponent(endpoint.path())

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let resp = response as? HTTPURLResponse,
          resp.statusCode == 200 else {
            throw APIError.serverError
          }
    
    return try decoder.decode(type, from: data)
  }
}
