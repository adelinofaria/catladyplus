//
//  CatBreedDetailScreen.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedDetailScreen: View {

    @Bindable var model: CatBreedModel

    var body: some View {

        CatBreedDetailView(model: model)
            .navigationTitle(self.model.name)
    }
}
