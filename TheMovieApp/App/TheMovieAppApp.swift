//
//  TheMovieAppApp.swift
//  TheMovieApp
//
//  Created by Jakub Zajda on 26/02/2022.
//

import SwiftUI

@main
struct TheMovieAppApp: App {
    
    @StateObject var favoritesItems = WatchlistItems()
    @StateObject var favoritePersons = FavoritePersons()
    @StateObject var movieDataServis = MovieDataService()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MainView(movieDataSerice: movieDataServis)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                SearchMovieView(movieDataService: movieDataServis)
                    .tabItem {
                        Image(systemName: "film")
                        Text("Search Movie")
                    }
                    .tag(1)
            }
            .environmentObject(favoritesItems)
            .environmentObject(favoritePersons)
            .accentColor(.yellow)
        }
    }
}
