//
//  WatchlistPosterViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 10/07/2022.
//

import Foundation
import SwiftUI

class WatchlistPosterViewModel: ObservableObject {
    let movie: WatchlistModel
    let id: Int
    @ObservedObject var movieDataService: MovieDataService
    @Published var url = URL(string: "")
    
    init(movie: WatchlistModel, movieDataService: MovieDataService) {
        self.movie = movie
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        self.id = Int(movie.id)
    }
    
    
}
