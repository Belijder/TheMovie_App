//
//  LongDetailViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/06/2022.
//

import Foundation
import SwiftUI

class LongDetailViewModel: ObservableObject {
    @EnvironmentObject var watchlistItems: WatchlistItems
    @ObservedObject var movieDataService: MovieDataService
    let topCastArray: [CastMember]
    let backdropPath: String?
    @Published var credits: Credits
    let itemDetails: ItemDetails
    let reviews: Reviews
    @Published var personsDetails: [PersonDetails] = []
    
    @Published var posterURL = URL(string: "")
    
    init(movieDataService: MovieDataService, topCastArray: [CastMember], backdropPath: String?, credits: Credits, itemDetails: ItemDetails, reviews: Reviews) {
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        self.topCastArray = topCastArray
        self.backdropPath = backdropPath
        self.credits = credits
        self.itemDetails = itemDetails
        self.reviews = reviews
        Task {
            self.posterURL = await movieDataService.makePosterImageURL(movieId: itemDetails.id)
        }
    }
    
    func getPersonDetailsForCastMembers() async {
        for person in self.credits.cast {
            if let details = await movieDataService.fetchPersonDetailsfor(id: person.id) {
                personsDetails.append(details)
            }
        }
    }
    
    func findIndexForPersonDetails(id: Int) -> Int? {
        personsDetails.firstIndex(where: { $0.id == id })
    }
    
    
    
}
