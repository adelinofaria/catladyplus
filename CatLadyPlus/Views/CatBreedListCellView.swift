//
//  CatBreedListCellView.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct CatBreedListCellView: View {

    let catBreed: CatBreedModel
    @State var favourite: Bool
    let showLifespan: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                AsyncImage(url: catBreed.image?.url) { phase in
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
                Text(catBreed.name)
                if showLifespan, let lifeSpan = self.catBreed.life_span {

                    Text("Lifespan: \(lifeSpan)yr")
                }
            }
            Button(action: {
                self.buttonTap()
            }) {
                Image(systemName: self.favourite ? "heart.fill" : "heart")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.red)
            }
        }
    }

    func buttonTap() {

        self.favourite = !self.favourite
    }
}
