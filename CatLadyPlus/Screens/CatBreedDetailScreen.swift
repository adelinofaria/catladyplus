//
//  CatBreedDetailScreen.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedDetailScreen: View {

    let catBreedModel: CatBreedModel

    var body: some View {

        CatBreedDetailView(viewModel: CatBreedDetailViewModel(catBreed: catBreedModel))
    }
}

struct CatBreedDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetailScreen(catBreedModel: CatBreedModel(name: "cat breed", favourite: false))
    }
}
