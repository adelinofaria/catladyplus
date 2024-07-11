//
//  CatBreedListViewModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

class CatBreedListViewModel: ObservableObject {

    enum Constants {

        static let paginationLimit = 10
    }

    @Published var presentingDataset: [CatBreedModel]
    @Published var favouriteIds: [String]
    @Published var errorText: String? = nil
    @Published var searchText = ""

    private let datasource: CatsDatasource
    let favouriteFilter: Bool

    private var dataset: [CatBreedModel] = [] {
        didSet {
            self.updatePresentedDataset()
        }
    }

    init(datasource: CatsDatasource, textFilter: String? = nil, favouriteFilter: Bool) {
        self.datasource = datasource
        self.favouriteFilter = favouriteFilter

        self.dataset = []
        self.presentingDataset = self.dataset
        self.favouriteIds = ["amis", "bali"]

        Task {
            do {
                dataset = try await datasource.requestBreeds(limit: Constants.paginationLimit, page: 0)
            } catch {
                await MainActor.run {
                    errorText = error.localizedDescription
                }
            }
        }
    }

    func updatePresentedDataset() {

        Task {

            let filteredDataset = dataset.filter { catBreed in

                let textFilterResult = self.searchText.count > 0 ? catBreed.name.contains(self.searchText) : true
                let favouriteFilterResult = self.favouriteFilter ? self.favouriteIds.contains(catBreed.id)  : true

                return textFilterResult && favouriteFilterResult
            }

            await MainActor.run {

                self.presentingDataset = filteredDataset
            }
        }
    }

    func isFavourite(catBreed: CatBreedModel) -> Bool {

        return self.favouriteIds.contains(catBreed.id)
    }
}
