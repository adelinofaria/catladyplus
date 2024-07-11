//
//  CatBreedDetailViewModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import Foundation

class CatBreedDetailViewModel: ObservableObject {

    let catBreed: CatBreedModel

    init(catBreed: CatBreedModel) {
        self.catBreed = catBreed
    }
}
