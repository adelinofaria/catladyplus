//
//  CatBreedListViewModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

class CatBreedListViewModel: ObservableObject {

    @Published var presentingCatBreeds: [CatBreedModel]

    private let favouriteFilter: Bool
    private let dataset: [CatBreedModel]

    init(favouriteFilter: Bool) {
        self.favouriteFilter = favouriteFilter
        self.dataset = [
            CatBreedModel(name: "Cat Breed 1"),
            CatBreedModel(name: "Cat Breed 2"),
            CatBreedModel(name: "Cat Breed 3"),
            CatBreedModel(name: "Cat Breed 4"),
            CatBreedModel(name: "Cat Breed 5"),
            CatBreedModel(name: "Cat Breed 6")
        ]

        self.presentingCatBreeds = self.dataset
    }

    func filter(text: String) {

        self.presentingCatBreeds = self.dataset.filter { $0.name.contains(text) }
    }
}
