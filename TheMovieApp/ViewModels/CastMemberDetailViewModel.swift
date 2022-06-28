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
    @Published var complexDetailsForCredits: [ComplexDataForLongDetailView] = []
    
    init(person: PersonDetails, movieDataService: MovieDataService) {
        self.personDetails = person
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        Task {
        self.profileURL = await movieDataService.getPathToProfileImageFor(id: personDetails.id)
        await getComplexDetailsForCredits()
        }
    }
    
    func getComplexDetailsForCredits() async {
        if let Credits = await movieDataService.fetchMovieCreditsFor(personID: personDetails.id) {
            let castCredits = Credits.cast
            for credit in castCredits {
                let character = credit.character
                let itemDetails = await movieDataService.fetchMovieDetails(id: credit.id)
        
                if let itemDetails = itemDetails {
                    let topCast = await movieDataService.makeTopCast(for: credit.id)
                    let reviews = await movieDataService.fetchReviews(movieID: credit.id)
                    let credits = await movieDataService.fetchCreditsfor(movieID: credit.id)
                    let backdropPath = itemDetails.backdropPath
                    let newCompexDetail = ComplexDataForLongDetailView(topCastArray: topCast, backdropPath: backdropPath, credits: credits, itemDetails: itemDetails, reviews: reviews, character: character)
                    complexDetailsForCredits.append(newCompexDetail)
                }
            }
        }
    }
}
