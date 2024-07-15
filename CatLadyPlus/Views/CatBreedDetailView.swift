//
//  CatBreedDetailView.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedDetailView: View {

    @Bindable var model: CatBreedModel

    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .center) {

                    AsyncImage(url: self.model.image?.url) { phase in
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
                    HStack {
                        Text("Breed:")
                            .bold()
                        Text(self.model.name)
                    }
                    HStack {
                        Text("Origin:")
                            .bold()
                        Text(self.model.origin ?? "n/a")
                    }
                    HStack {
                        Text("Temperament:")
                            .bold()
                        Text(self.model.temperament ?? "n/a")
                    }
                    HStack {
                        Text("Description:")
                            .bold()
                        Text(self.model.modelDescription ?? "n/a")
                    }
                }

                Button(action: {
                    self.model.favourite = !(self.model.favourite ?? false)
                }) {
                    Image(systemName: self.model.favourite ?? false ? "heart.fill" : "heart")
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundColor(.red)
                }
            }
        }
    }
}
