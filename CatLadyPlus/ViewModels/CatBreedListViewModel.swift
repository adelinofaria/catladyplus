//
//  CatBreedListViewModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

extension CatBreedListView {

    class ViewModel: ObservableObject {

        let datasource: CatsDatasource
        let favouriteFilter: Bool

        @Published var presentedDataset: [CatBreedTuple] = []

        @Published var errorText: String? = nil
        @Published var searchText = ""

        private var lastItem = false
        private var dataset: [CatBreedModel] = []

        init(datasource: CatsDatasource, favouriteFilter: Bool) {
            self.datasource = datasource
            self.favouriteFilter = favouriteFilter
        }

        func fetchDataset() {

            Task {
                do {
                    let dataset = try await datasource.requestBreeds()

                    self.dataset = dataset
                    self.lastItem = false

                    await MainActor.run {
                        self.updatePresentedDataset()
                    }
                } catch {
                    await MainActor.run {
                        self.errorText = error.localizedDescription
                    }
                }
            }
        }

        func fetchNextPage() {

            if self.lastItem == false {

                Task {
                    do {
                        let dataset = try await datasource.requestBreedsNextPage()

                        self.lastItem = dataset.count == 0

                        self.dataset.append(contentsOf: dataset)

                        await MainActor.run {
                            self.updatePresentedDataset()
                        }
                    } catch {
                        await MainActor.run {
                            self.errorText = error.localizedDescription
                        }
                    }
                }
            }
        }

        func updatePresentedDataset() {

            Task {

                let filteredDataset = dataset.filter { catBreed in

                    let textFilterResult = self.searchText.count > 0 ? catBreed.name.contains(self.searchText) : true
                    let favouriteFilterResult = self.favouriteFilter ? self.datasource.isFavourite(catBreedId: catBreed.id)  : true

                    return textFilterResult && favouriteFilterResult

                }.map {
                    CatBreedTuple(catBreed: $0, favourite: self.datasource.isFavourite(catBreedId: $0.id))
                }

                await MainActor.run {

                    self.presentedDataset = filteredDataset
                }
            }
        }
    }
}
