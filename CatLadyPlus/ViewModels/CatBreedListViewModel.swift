//
//  CatBreedListViewModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI
import SwiftData

extension CatBreedListView {

    @Observable
    class ViewModel {

        let datasource: CatsDatasource
        let favouriteFilter: Bool
        var searchText = ""

        var errorDescription: String? = nil
        var isShowingError: Bool = false

        init(datasource: CatsDatasource, favouriteFilter: Bool) {
            self.datasource = datasource
            self.favouriteFilter = favouriteFilter
        }

        func locelFilterOfQueryResults(items: [CatBreedModel]) -> [CatBreedModel] {

            let items = items.filter {
                let favouriteFilter = self.favouriteFilter ? ($0.favourite ?? false) : true
                let textSearchFilter = self.searchText.isEmpty ? true : ($0.name.contains(self.searchText))

                return favouriteFilter && textSearchFilter
            }

            return items
        }

        func fetchDataset(limit: Int, page: Int) async -> [CatBreedModel]? {

            do {
                let dataset = try await self.datasource.requestBreeds(limit: limit, page: page)

                return dataset
            } catch {

                self.errorDescription = (error as? LocalizedError)?.errorDescription
                self.isShowingError = self.errorDescription != nil

                return nil
            }
        }

        func mergeExternalDataset(localDataset: [CatBreedModel], externalDataset: [CatBreedModel]) {

            // Update incoming dataset with client-side only info (favourites)
            externalDataset.forEach { item in
                let correspondingStoredModel = localDataset.filter { $0.id == item.id }.first

                item.favourite = correspondingStoredModel?.favourite ?? false
            }
        }
    }
}
