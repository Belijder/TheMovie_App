//
//  ShortDetailItemViewViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 09/03/2022.
//

import SwiftUI

@MainActor class ShortDetailItemViewViewModel: ObservableObject {
    
    init(items: [ItemDetails]) {
        _movieDataService = ObservedObject(wrappedValue: MovieDataService())
        self.items = items
    }
    
    @ObservedObject var movieDataService: MovieDataService
    
    @Published var items: [ItemDetails]
    @Published var topCasts = [[CastMember]]()
    @Published var reviews: [Int:Reviews] = [:]
    
    @Published var isProgresViewEnabled = true
    
    func fetchCastAndReviews() async  {
        isProgresViewEnabled = true
        let ids = await movieDataService.fetchPopularMoviesIDs(from: items)
        for id in ids {
            await topCasts.append(movieDataService.makeTopCast(for: id))
            await reviews[id] = movieDataService.fetchReviews(movieID: id)
        }
        isProgresViewEnabled = false
        
    }
}
