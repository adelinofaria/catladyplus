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

    @StateObject var viewModel: CatBreedListViewModel

    @Environment(\.isSearching) var isSearching

    var body: some View {

        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: Constants.cellHeight)),
                GridItem(.flexible(minimum: Constants.cellHeight)),
            ]) {
                ForEach(0..<self.viewModel.presentingDataset.count, id: \.self) { index in
                    NavigationLink {
                        CatBreedDetailScreen(catBreedModel: self.viewModel.presentingDataset[index])
                    } label: {
                        Text(self.viewModel.presentingDataset[index].name)
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Breeds of cats")
        .onSubmit(of: .search) {
            self.performSearch()
        }
        .onChange(of: self.viewModel.searchText) { newValue in
            if !isSearching, newValue.count == 0 {

                self.performSearch()
            }
        }
    }

    // MARK: Private

    private func performSearch() {

        self.viewModel.updatePresentedDataset()
    }
}

struct CatBreedListView_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedListView(viewModel: CatBreedListViewModel(datasource: CatsDatasource(), favouriteFilter: false))
    }
}
