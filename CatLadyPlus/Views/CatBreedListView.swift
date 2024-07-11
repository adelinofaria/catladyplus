//
//  CatBreedListView.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedListView: View {

    enum Constants {
        static let cellHeight: CGFloat = 50
    }

    @State private var searchText = ""

    @StateObject var viewModel: CatBreedListViewModel

    var body: some View {

        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: Constants.cellHeight)),
                GridItem(.flexible(minimum: Constants.cellHeight)),
            ]) {
                ForEach(0..<self.viewModel.presentingCatBreeds.count, id: \.self) { index in
                    NavigationLink {
                        CatBreedDetailScreen(catBreedModel: self.viewModel.presentingCatBreeds[index])
                    } label: {
                        Text(self.viewModel.presentingCatBreeds[index].name)
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            self.performSearch()
        }
    }

    // MARK: Private

    private func performSearch() {

        self.viewModel.filter(text: self.searchText)
    }
}

struct CatBreedListView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedListView(viewModel: CatBreedListViewModel(favouriteFilter: false))
    }
}
