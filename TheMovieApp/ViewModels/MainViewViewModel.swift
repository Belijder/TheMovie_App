//
//  MainViewViewModel.swift
//  TheMovieApp
//
//  Created by Jakub Zajda on 26/02/2022.
//

import Foundation
import SwiftUI

@MainActor class MainViewViewModel: ObservableObject {
    
    @ObservedObject var movieDataService: MovieDataService
    @Published var popularMovies: [ItemDetails] = []
    @Published var popularMoviesProgressView = true
    
    
    func getPopularMovies() async {
        popularMoviesProgressView = true
        let moviesArray = await movieDataService.fetchPopularMovies()
        self.popularMovies = await movieDataService.fetchPopularMoviesDetails(from: moviesArray)
        popularMoviesProgressView = false
    }
    
    func getPopularMoviesIDs() async -> [Int] {
        return await movieDataService.fetchPopularMoviesIDs(from: popularMovies)
    }
    


    
    init(movieDataService: MovieDataService) {
        _movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
}
