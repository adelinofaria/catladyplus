//
//  CatBreedListView.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI
import SwiftData

struct CatBreedListView: View {

    enum Constants {
        static let minimumCellWidth: CGFloat = 100
        static let paginationLimit = 10
    }

    @Environment(\.isSearching) var isSearching
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CatBreedModel.name, order: .forward) private var items: [CatBreedModel]

    @State var viewModel: ViewModel

    var body: some View {

        let items = self.locelFilterOfQueryResults(items: self.items)

        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(.flexible(minimum: Constants.minimumCellWidth)), count: 2)) {
                ForEach(items, id: \.self) { item in

                    NavigationLink {
                        CatBreedDetailScreen(model: item)
                    } label: {
                        CatBreedListCellView(model: item, showLifespan: self.viewModel.favouriteFilter)
                            .accessibilityIdentifier("CatBreedListCellView")
                    }
                    .onAppear() {
                        self.cellOnAppear(items: items, item: item)
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Breeds of cats")
        .task {
            self.fetchDataset(limit: Constants.paginationLimit, page: 0)
        }
    }

    // MARK: Private

    private func locelFilterOfQueryResults(items: [CatBreedModel]) -> [CatBreedModel] {

        let items = items.filter {
            let favouriteFilter = self.viewModel.favouriteFilter ? ($0.favourite ?? false) : true
            let textSearchFilter = self.viewModel.searchText.isEmpty ? true : ($0.name.contains(self.viewModel.searchText))

            return favouriteFilter && textSearchFilter
        }

        return items
    }

    private func cellOnAppear(items: [CatBreedModel], item: CatBreedModel) {

        if let index = items.firstIndex(of: item) {

            if index == 0 {
                // First item, we check how recent page0 models are
                let isFreshContent = item.timestamp.timeIntervalSinceNow < 300

                if !isFreshContent {

                    self.fetchDataset(limit: Constants.paginationLimit, page: 0)
                }
            } else if index % Constants.paginationLimit == 0 {
                // First item of a page, we check how recent pageN models are
                let isFreshContent = item.timestamp.timeIntervalSinceNow < 300
                let pageMultiplier = index / Constants.paginationLimit

                if !isFreshContent {

                    self.fetchDataset(limit: Constants.paginationLimit, page: pageMultiplier)
                }
            } else if ((index + 1) % Constants.paginationLimit == 0) && items.last == item {
                // At last item of a page, we check if it's the last of the collection
                // that means we request another page
                let pageMultiplier = (index + 1) / Constants.paginationLimit

                self.fetchDataset(limit: Constants.paginationLimit, page: pageMultiplier)
            }
        }
    }

    func fetchDataset(limit: Int, page: Int) {

        Task {
            do {
                let dataset = try await self.viewModel.datasource.requestBreeds(limit: limit, page: page)
                let datasetIds = dataset.map { $0.id }

                let predicate = #Predicate<CatBreedModel> {
                    datasetIds.contains($0.id)
                }

                let storedModels = try modelContext.fetch(FetchDescriptor<CatBreedModel>(predicate: predicate))

                // Update incoming dataset with client-side only info (favourites)
                dataset.forEach { item in
                    let correspondingStoredModel = storedModels.filter { $0.id == item.id }.first

                    item.favourite = correspondingStoredModel?.favourite ?? false
                }

                await MainActor.run {
                    withAnimation {
                        dataset.forEach { modelContext.insert($0) }
                    }
                }

            } catch {

                // TODO: deal with catch
                switch error {
                case Networking.NetworkingError.networking:
                    print("networking yikers")
                case Networking.NetworkingError.badResponse:
                    print("badresponse yikers")
                case Networking.NetworkingError.parsing:
                    print("parsing yikers")
                default:
                    print("yikers")
                }
            }
        }
    }
}
