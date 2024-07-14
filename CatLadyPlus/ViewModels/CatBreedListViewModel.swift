//
//  CatBreedListViewModel.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

extension CatBreedListView {

    @Observable
    class ViewModel {

        let datasource: CatsDatasource
        let favouriteFilter: Bool

        var errorText: String? = nil
        var searchText = ""

        private var lastItem = false

        init(datasource: CatsDatasource, favouriteFilter: Bool) {
            self.datasource = datasource
            self.favouriteFilter = favouriteFilter
        }
    }
}
