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
    @Published var itemDetails: ItemDetails?
    @Published var reviews: Reviews?
    @Published var topcastArray = [CastMember]()
    @Published var credits: Credits?
    @Published var backdropPath: String?
    
    func getMovieDetails() async -> ItemDetails? {
        return await movieDataService.fetchMovieDetails(id: id)
    }
    
    func getReviews() async -> Reviews {
        return await movieDataService.fetchReviews(movieID: id)
    }
    
    func getCredits() async -> Credits {
        return await movieDataService.fetchCreditsfor(movieID: id)
    }
    
    func getTopCastArray() async -> [CastMember] {
        return await movieDataService.makeTopCast(for: id)
    }
    
    init(movie: WatchlistModel, movieDataService: MovieDataService) {
        self.movie = movie
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        self.id = Int(movie.id)
        Task {
            itemDetails = await getMovieDetails()
            backdropPath = itemDetails?.backdropPath
        }
        Task {
            reviews = await getReviews()
        }
        Task {
            credits = await getCredits()
        }
        Task {
            topcastArray = await getTopCastArray()
        }
    }
    
    
}
