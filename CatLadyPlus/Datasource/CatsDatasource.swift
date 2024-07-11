//
//  CatsDatasource.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

class CatsDatasource {

    func requestBreeds() async throws -> [CatBreedModel] {

        return [
            CatBreedModel(name: "Cat Breed 1", favourite: false),
            CatBreedModel(name: "Cat Breed 2", favourite: false),
            CatBreedModel(name: "Cat Breed 3", favourite: true),
            CatBreedModel(name: "Cat Breed 4", favourite: false),
            CatBreedModel(name: "Cat Breed 5", favourite: false),
            CatBreedModel(name: "Cat Breed 6", favourite: true)
        ]
    }
}
