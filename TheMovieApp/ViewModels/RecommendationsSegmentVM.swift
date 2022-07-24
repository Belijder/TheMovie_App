//
//  RecommendationsSegmentVM.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 17/07/2022.
//

import Foundation
import SwiftUI

class RecommendationsSegmentVM: ObservableObject {
    
    @Published var selectedItem = 0
    @Published var showProgressView = false
    @Published var recommendations = [ItemDetails]()
    @ObservedObject var movieDataService: MovieDataService
    @ObservedObject var coreDataManager: CoreDataManager
    @Published var recommendationItem: RatedItemModel?
    
    func getMovieIdForRecommendations() {
        let ratedMovies = coreDataManager.savedUserRatingsItems
        let filteredMovies = ratedMovies.filter { $0.userRate > 7 }
        let sortedMovies = filteredMovies.sorted(by: { $0.ratingDate < $1.ratingDate })
        recommendationItem = sortedMovies[0]
    }
    
    func getRecommendations() async {
        showProgressView = true
        if recommendationItem != nil {
            let moviesArray = await movieDataService.fetchRecommendationsFor(id: recommendationItem!.id)
            self.recommendations = await movieDataService.fetchPopularMoviesDetails(from: moviesArray)
            
        }
        showProgressView = false
    }
    
    init(movieDataService: MovieDataService, coreDataManager: CoreDataManager) {
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        self._coreDataManager = ObservedObject(wrappedValue: coreDataManager)
    }
    
}
