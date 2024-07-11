//
//  CatBreedListViewModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

class CatBreedListViewModel: ObservableObject {

    @Published var presentingDataset: [CatBreedModel]
    @Published var errorText: String? = nil
    @Published var searchText = ""

    private let datasource: CatsDatasource

    private let favouriteFilter: Bool

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

        Task {
            do {
                dataset = try await datasource.requestBreeds()
            } catch {
                errorText = error.localizedDescription
            }
        }
    }

    func updatePresentedDataset() {

        Task {

            let filteredDataset = dataset.filter { catBreed in

                let textFilterResult = self.searchText.count > 0 ? catBreed.name.contains(self.searchText) : true
                let favouriteFilterResult = self.favouriteFilter ? catBreed.favourite : true

                return textFilterResult && favouriteFilterResult
            }

            await MainActor.run {

                self.presentingDataset = filteredDataset
            }
        }
    }
}
