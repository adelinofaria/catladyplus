//
//  RootScreen.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI

struct RootScreen: View {
    var body: some View {
        TabView {
            NavigationStack {
                CatBreedListScreen()
                    .navigationTitle("Compendium")
            }
            .tabItem {
                Label("Breeds", systemImage: "list.dash")
            }
            NavigationStack {
                CatBreedListScreen(favouriteFilter: true)
                    .navigationTitle("Favourites")
            }
            .tabItem {
                Label("Favourites", systemImage: "heart")
            }
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
