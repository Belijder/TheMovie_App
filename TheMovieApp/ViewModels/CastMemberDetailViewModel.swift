//
//  CastMemberDetailsViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 21/06/2022.
//

import Foundation
import SwiftUI

class CastMemberDetailViewModel: ObservableObject {
    
    @ObservedObject var movieDataService: MovieDataService
    
    let personDetails: PersonDetails
    @Published var profileURL: URL?
    
    @Published var movieCredits: [(String, ItemDetails)] = []
    
    init(person: PersonDetails, movieDataService: MovieDataService) {
        self.personDetails = person
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        Task {
        self.profileURL = await movieDataService.getPathToProfileImageFor(id: personDetails.id)
        await getMovieCredits()
        }
    }
    
    func getMovieCredits() async {
        if let Credits = await movieDataService.fetchMovieCreditsFor(personID: personDetails.id) {
            let castCredits = Credits.cast
            for credit in castCredits {
                let character = credit.character
                let itemDetails = await movieDataService.fetchMovieDetails(id: credit.id)
                
                if let itemDetails = itemDetails {
                    self.movieCredits.append((character,itemDetails))
                }
            }
        }
    }
}
