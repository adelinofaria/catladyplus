//
//  CatBreedListScreen.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedListScreen: View {

    let favouriteFilter: Bool

    init(favouriteFilter: Bool = false) {
        self.favouriteFilter = favouriteFilter
    }

    var body: some View {

        CatBreedListView(viewModel: CatBreedListViewModel(favouriteFilter: self.favouriteFilter))
    }
}

struct CatBreedListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedListScreen()
    }
}
