//
//  CatBreedDetailScreen.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedDetailScreen: View {

    let datasource: CatsDatasource

    @Binding var tuple: CatBreedTuple

    var body: some View {

        CatBreedDetailView(datasource: self.datasource, tuple: $tuple)
            .navigationTitle(self.tuple.catBreed.name)
    }
}
