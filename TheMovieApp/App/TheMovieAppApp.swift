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
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(favoritesItems)
        }
    }
}
