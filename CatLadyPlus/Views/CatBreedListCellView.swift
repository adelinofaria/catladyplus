//
//  CatBreedListCellView.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedListCellView: View {

    @Bindable var model: CatBreedModel

    let showLifespan: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                AsyncImage(url: self.model.image?.url, scale: 0.25) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .aspectRatio(contentMode: .fit)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .clipped()
                            .aspectRatio(1, contentMode: .fit)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 150, height: 150)
                Text(self.model.name)
                if self.showLifespan, let lifeSpan = self.model.life_span {

                    Text("Lifespan: \(lifeSpan)yr")
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
