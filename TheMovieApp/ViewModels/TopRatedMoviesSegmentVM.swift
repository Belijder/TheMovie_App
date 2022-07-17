//
//  TopRatedMoviesSegmentVM.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 17/07/2022.
//

import Foundation
import SwiftUI

class TopRatedMoviesSegmentVM: ObservableObject {
    
    @Published var selectedItem = 0
    @Published var showProgressView = false
    @Published var topRatedMoviesDetails = [ItemDetails]()
    @ObservedObject var movieDataService: MovieDataService
    
    func getTopRatedMoviesDetails() async {
        showProgressView = true
        let moviesArray = await movieDataService.fetchTopRatedMovies()
        self.topRatedMoviesDetails = await movieDataService.fetchPopularMoviesDetails(from: moviesArray)
        showProgressView = false
    }
    
    init(movieDataService: MovieDataService) {
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
    
}
