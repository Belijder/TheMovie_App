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
            MainView(movieDataSerice: movieDataServis)
                .environmentObject(favoritesItems)
                .environmentObject(favoritePersons)
        }
    }
}
