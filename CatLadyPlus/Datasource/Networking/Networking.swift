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

    enum NetworkingError: Error, LocalizedError {

        case networking
        case badResponse
        case parsing

        var errorDescription: String? {

            switch self {
            case .networking:
                return "An error occured while trying to connect"
            case .badResponse:
                return "An error occured due a bad response from server"
            case .parsing:
                return "An error occured while trying to parse server response"
            }
        }
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

                    throw NetworkingError.parsing
                }

            } else {

                throw NetworkingError.badResponse
            }
        } catch {

            throw NetworkingError.networking
        }
    }
}
