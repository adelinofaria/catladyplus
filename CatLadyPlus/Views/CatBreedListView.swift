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

        let items = self.viewModel.locelFilterOfQueryResults(items: self.items)

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
        .alert("Error",
               isPresented: $viewModel.isShowingError,
               actions: { },
               message: { Text(viewModel.errorDescription ?? "") })
        .task {
            await self.viewWillAppearTask()
        }
    }

    // MARK: Private

    /// Figures out the pagination logic based on grid cell's index.
    /// - Parameters:
    ///   - items: Grid full dataset
    ///   - item: Grid cell item
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

    /// When view is about to appear we request first page of models
    private func viewWillAppearTask() async {

        self.fetchDataset(limit: Constants.paginationLimit, page: 0)
    }
    
    /// Request the pagination of cat breed models and also merge local managed properties (CatBreedModel.favourite) before sending models to persistent store
    /// Function placed here, due modelContext ownership
    /// - Parameters:
    ///   - limit: Request page size
    ///   - page: Request page index
    private func fetchDataset(limit: Int, page: Int) {

        Task {
            // start by requesting server data
            if let dataset = await self.viewModel.fetchDataset(limit: limit, page: page) {

                // Fetch local corresponding objects
                let datasetIds = dataset.map { $0.id }

                let fetchDescriptor = FetchDescriptor<CatBreedModel>(predicate: #Predicate {
                    datasetIds.contains($0.id)
                })

                let storedModels = try modelContext.fetch(fetchDescriptor)

                // Copy local-only porperties to the recently downloaded new models
                // Avoiding the local state overwrite
                self.viewModel.mergeExternalDataset(localDataset: storedModels, externalDataset: dataset)


                // Update persistant storage on main actor
                await MainActor.run {
                    withAnimation {
                        dataset.forEach { modelContext.insert($0) }
                    }
                }
            }
        }
    }
}
