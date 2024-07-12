//
//  CatBreedDetailView.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedDetailView: View {

    let datasource: CatsDatasource

    @Binding var tuple: CatBreedTuple

    @State var favourite: Bool = false

    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .center) {

                    AsyncImage(url: self.tuple.catBreed.image?.url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .clipped()
                                .aspectRatio(1, contentMode: .fit)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    Text("Breed:")
                    Text(self.tuple.catBreed.name)
                    Text("Origin:")
                    Text(self.tuple.catBreed.origin ?? "n/a")
                    Text("Temperament:")
                    Text(self.tuple.catBreed.temperament ?? "n/a")
                    Text("Description:")
                    Text(self.tuple.catBreed.description ?? "n/a")
                }

                Button(action: {
                    Task {
                        let favourite = await self.datasource.toggleFavourite(catBreedId: self.tuple.catBreed.id)

                        await MainActor.run {
                            self.tuple.favourite = favourite
                            self.favourite = self.tuple.favourite
                        }
                    }
                }) {
                    Image(systemName: self.favourite ? "heart.fill" : "heart")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(.red)
                }
            }
        }
        .task {
            self.favourite = self.tuple.favourite
        }
    }
}
