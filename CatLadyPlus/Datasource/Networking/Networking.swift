//
//  Networking.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

class Networking {

    enum Constants {
        static let successResponseRange = 200...299
    }

    enum NetworkingError: Error {

        case networking
        case badResponse
        case parsing
    }

    let urlsession = URLSession(configuration: URLSessionConfiguration.default)

    func perform<T>(request: URLRequest) async throws -> T where T: Decodable {

        do {

            let (data, response) = try await self.urlsession.data(for: request)

            if let validResponse = response as? HTTPURLResponse,
               Constants.successResponseRange ~= validResponse.statusCode {

                do {

                    let model = try JSONDecoder().decode(T.self, from: data)

                    return model

                } catch {

                    print(error)

                    throw NetworkingError.parsing
                }

            } else {

                throw NetworkingError.badResponse
            }
        } catch {

            print(error)

            throw NetworkingError.networking
        }
    }
}
