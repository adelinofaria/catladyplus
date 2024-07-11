//
//  CatBreedDetailView.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedDetailView: View {

    @StateObject var viewModel: CatBreedDetailViewModel

    var body: some View {
        Text(self.viewModel.catBreed.name)
        Text("favourite = \(self.viewModel.catBreed.favourite.description)")
    }
}

struct CatBreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetailView(viewModel: CatBreedDetailViewModel(catBreed: CatBreedModel(name: "cat breed", favourite: false)))
    }
}
