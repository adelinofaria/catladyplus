//
//  CatsApiEndpoint.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 12/07/2024.
//

import Foundation

enum CatsApiEndpoint {

    case breeds(limit: Int, page: Int)

    static let baseURL = URL(string: "https://api.thecatapi.com/v1/")!
    static let apiKey = <#T##API_KEY#>

    var url: URL {

        let path: String

        switch self {
        case .breeds:
            path = "breeds"
        }

        var url = CatsApiEndpoint.baseURL.appending(path: path)

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
            "x-api-key": CatsApiEndpoint.apiKey
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
