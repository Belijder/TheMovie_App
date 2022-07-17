//
//  HorizontalStyleMovieCellViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 16/07/2022.
//

import Foundation
import SwiftUI

class HorizontalStyleMovieCellViewModel: ObservableObject {
    let id: Int
    let title: String
    let releaseDate: String
    let voteAverage: Double
    let userRating: Int?
    let ratingDate: Date?
    let posterPath: String
    let runtime: Int?
    
    
    @ObservedObject var movieDataService: MovieDataService
    
    @Published var url = URL(string: "")
    @Published var complexdetails: ComplexDataForLongDetailView?
    
    func getURL() async {
        url = await movieDataService.makePosterImageURL(movieId: id)
    }
    
    func getComplexDetails() async {
        complexdetails = await movieDataService.fetchComplexDataForLongDetailView(id: id)
    }

    
    init(id: Int, title: String, releaseDate: String, voteAverage: Double, userRating: Int? = nil, ratingDate: Date? = nil, posterPath: String, runtime: Int?, movieDataService: MovieDataService) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.userRating = userRating
        self.ratingDate = ratingDate
        self.posterPath = posterPath
        self.runtime = runtime
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
}
