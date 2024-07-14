//
//  CatsDatasource.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

actor CatsDatasource {

    let networking = Networking()

    func requestBreeds(limit: Int, page: Int) async throws -> [CatBreedModel] {

        let endpoint = CatsApiEndpoint.breeds(limit: limit, page: page)

        let models: [CatBreedModel] = try await self.networking.perform(request: endpoint.request)

        return models
    }
}
