//
//  SearchMovieCellViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 28/06/2022.
//

import Foundation
import SwiftUI

class SearchMovieCellViewModel: ObservableObject {
    @ObservedObject var movieDataService: MovieDataService
    let id: Int
    
    init(movieDataService: MovieDataService, id: Int) {
        self.movieDataService = movieDataService
        self.id = id
        Task {
            await getComplexDetailsForMovie()
        }
        
    }
    
    @Published var complexDataForMovie: [ComplexDataForLongDetailView] = []
    
    func getComplexDetailsForMovie() async {
        let character = ""
        let itemDetails = await movieDataService.fetchMovieDetails(id: id)
        
        if let itemDetails = itemDetails {
            let topCast = await movieDataService.makeTopCast(for: id)
            let reviews = await movieDataService.fetchReviews(movieID: id)
            let credits = await movieDataService.fetchCreditsfor(movieID: id)
            let backdropPath = itemDetails.backdropPath
            let newCompexDetail = ComplexDataForLongDetailView(topCastArray: topCast, backdropPath: backdropPath, credits: credits, itemDetails: itemDetails, reviews: reviews, character: character)
            complexDataForMovie.append(newCompexDetail)
        }
    }
}
