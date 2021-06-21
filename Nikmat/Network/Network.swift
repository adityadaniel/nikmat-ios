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
    case search(query: String)
    case featuredArticles
    case recipeDetail(key: String)

    func path() -> String {
      switch self {
      case .featuredRecipes:
        return "recipes"
      case .featuredArticles:
        return "featured/articles"
      case let .recipeDetail(key: key):
        return "recipes/\(key)"
      case .search:
        return "search/"
      }
    }

    func queryItems() -> [URLQueryItem]? {
      switch self {
      case .featuredRecipes, .featuredArticles, .recipeDetail:
        return nil
      case let .search(query: query):
        let queryItem = URLQueryItem(name: "q", value: query)
        return [queryItem]
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

    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
      throw APIError.invalidUrl
    }

    if let queryItems = endpoint.queryItems() {
      urlComponents.queryItems = queryItems
    }

    guard let urlRequest = urlComponents.url else {
      throw APIError.invalidUrl
    }

    let (data, response) = try await URLSession.shared.data(from: urlRequest)
    guard let resp = response as? HTTPURLResponse,
          resp.statusCode == 200
    else {
      throw APIError.serverError
    }

    do {
      return try decoder.decode(type, from: data)
    } catch {
      throw APIError.decodingError
    }
  }
}
