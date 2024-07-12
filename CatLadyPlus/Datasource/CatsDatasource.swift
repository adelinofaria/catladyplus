//
//  CatsDatasource.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

actor CatsDatasource {

    enum Constants {

        static let paginationLimit = 10
        static let userDefaultsFavouritesKey = "favourites"
    }

    let networking = Networking()

    private var breedsPage = 0
    private var lastPage = false
    private var catBreeds: [CatBreedModel] = []

    // MARK: Breeds

    func requestBreeds() async throws -> [CatBreedModel] {

        if self.catBreeds.count > 0 {

            return self.catBreeds

        } else {

            let endpoint = CatsApiEndpoint.breeds(limit: Constants.paginationLimit, page: self.breedsPage)

            let models: [CatBreedModel] = try await self.networking.perform(request: endpoint.request)

            if models.count != Constants.paginationLimit {

                self.lastPage = true
            }

            self.catBreeds = models

            return models
        }
    }

    func requestBreedsNextPage() async throws -> [CatBreedModel] {

        if lastPage == false {

            self.breedsPage += 1

            let endpoint = CatsApiEndpoint.breeds(limit: Constants.paginationLimit, page: self.breedsPage)

            let models: [CatBreedModel] = try await self.networking.perform(request: endpoint.request)

            if models.count != Constants.paginationLimit {

                self.lastPage = true
            }

            self.catBreeds.append(contentsOf: models)

            return models

        } else {

            return []
        }
    }

    // MARK: Favourites

    nonisolated func isFavourite(catBreedId: String) -> Bool {

        let favourites = UserDefaults.standard.array(forKey: Constants.userDefaultsFavouritesKey) as? [String]

        return favourites?.contains(catBreedId) ?? false
    }

    func toggleFavourite(catBreedId: String) -> Bool {

        var favourites = (UserDefaults.standard.array(forKey: Constants.userDefaultsFavouritesKey) as? [String]) ?? []

        let isFavourite = favourites.contains(catBreedId)


        if isFavourite, let index = favourites.firstIndex(of: catBreedId) {

            favourites.remove(at: index)

        } else {

            favourites.append(catBreedId)
        }

        UserDefaults.standard.set(favourites, forKey: Constants.userDefaultsFavouritesKey)

        return !isFavourite
    }
}
