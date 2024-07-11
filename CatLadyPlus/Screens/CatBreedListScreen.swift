//
//  CatBreedListScreen.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedListScreen: View {

    let datasource: CatsDatasource
    let favouriteFilter: Bool

    init(datasource: CatsDatasource, favouriteFilter: Bool = false) {
        self.datasource = datasource
        self.favouriteFilter = favouriteFilter
    }

    var body: some View {

        CatBreedListView(viewModel: CatBreedListViewModel(datasource: self.datasource, favouriteFilter: self.favouriteFilter))
    }
}

struct CatBreedListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedListScreen(datasource: CatsDatasource())
    }
}
