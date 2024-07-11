//
//  CatsDatasource.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

class CatsDatasource {

    enum Endpoints {

        case breeds(limit: Int, page: Int)

        static let baseURL = URL(string: "https://api.thecatapi.com/v1/")!
        static let apiKey = "live_J7NIuEGjeCIx9Buz966PKPJL7OnKdCK1CUQkVrkbCm6qx1iyGBFDINT1PGKjgc2N"

        var url: URL {

            let path: String

            switch self {
            case .breeds:
                path = "breeds"
            }

            var url = Endpoints.baseURL.appending(path: path)

            if let additionalQueryItems = self.queryItems,
               var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {

                var queryItems = urlComponents.queryItems ?? []

                queryItems.append(contentsOf: additionalQueryItems)

                urlComponents.queryItems = queryItems

                if let queryStringURL = urlComponents.url {

                    url = queryStringURL
                }
            }


            return url
        }

        var headers: [String: String] {

            let baseHeaders: [String: String] = [
                "Content-Type": "application/json",
                "x-api-key": Endpoints.apiKey
            ]

            return baseHeaders
        }

        var queryItems: [URLQueryItem]? {

            let dictionary: [String: String]

            switch self {
            case .breeds(let limit, let page):
                dictionary = [
                    "limit": String(limit),
                    "page": String(page)
                ]
            }

            return dictionary.map { URLQueryItem(name: $0, value: $1) }
        }

        var request: URLRequest {

            var request = URLRequest(url: self.url)

            self.headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

            return request
        }
    }

    let networking = Networking()

    func requestBreeds(limit: Int, page: Int) async throws -> [CatBreedModel] {

        let endpoint = Endpoints.breeds(limit: limit, page: page)

        let models: [CatBreedModel] = try await self.networking.perform(request: endpoint.request)

        return models
    }

    func requestFavourites() -> [String] {

        return []
    }
}
