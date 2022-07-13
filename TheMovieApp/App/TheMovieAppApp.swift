//
//  TheMovieAppApp.swift
//  TheMovieApp
//
//  Created by Jakub Zajda on 26/02/2022.
//

import SwiftUI

@main
struct TheMovieAppApp: App {
    
    @StateObject var movieDataService = MovieDataService()
    @StateObject var coreDataManager = CoreDataManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MainView(movieDataSerice: movieDataService)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                SearchMovieView(movieDataService: movieDataService)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(1)
                UserItemsView(coreDataManager: coreDataManager, movieDataService: movieDataService)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("You")
                    }
                    .tag(2)
            }
            .environmentObject(coreDataManager)
            .accentColor(.yellow)
        }
    }
}
