//
//  RootScreen.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct RootScreen: View {

    let catsDatasource = CatsDatasource()

    var body: some View {
        TabView {
            NavigationStack {
                CatBreedListScreen(datasource: self.catsDatasource)
                    .navigationTitle("Compendium")
            }
            .tabItem {
                Label("Breeds", systemImage: "list.dash")
            }
            NavigationStack {
                CatBreedListScreen(datasource: self.catsDatasource, favouriteFilter: true)
                    .navigationTitle("Favourites")
            }
            .tabItem {
                Label("Favourites", systemImage: "heart")
            }
        }
    }
}

#Preview {
    RootScreen()
}
