//
//  CatBreedListView.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedListView: View {

    enum Constants {
        static let minimumCellWidth: CGFloat = 100
    }

    @Environment(\.isSearching) var isSearching

    @ObservedObject var viewModel: ViewModel

    var body: some View {

        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: Constants.minimumCellWidth)), count: 2)) {
                ForEach($viewModel.presentedDataset, id: \.self) { $catBreed in
                    NavigationLink {
                        CatBreedDetailScreen(datasource: self.viewModel.datasource, tuple: $catBreed)
                    } label: {

                        CatBreedListCellView(
                            datasource: self.viewModel.datasource,
                            tuple: $catBreed,
                            showLifespan: self.viewModel.favouriteFilter
                        )
                        .accessibilityIdentifier("CatBreedListCellView")
                    }
                    .onAppear() {
                        if viewModel.presentedDataset.count > 0,
                           catBreed == viewModel.presentedDataset.last {

                            self.viewModel.fetchNextPage()
                        }
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
        .task {
            self.viewModel.fetchDataset()
        }
    }

    // MARK: Private

    private func performSearch() {

        self.viewModel.updatePresentedDataset()
    }
}
