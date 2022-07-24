//
//  RecommendationsFromFavoritesSegmentVM.swift
//  TheMovieApp
//
//  Created by Jakub Zajda on 24/07/2022.
//

import Foundation
import SwiftUI

class RecommendationsFromFavoritesSegmentVM: ObservableObject {
    
    @Published var selectedItem = 0
    @Published var showProgressView = false
    @Published var recommendations = [ItemDetails]()
    @ObservedObject var movieDataService: MovieDataService
    @ObservedObject var coreDataManager: CoreDataManager
    @Published var recommendationItem: FavoriteModel?
    
    func getMovieIdForRecommendations() {
        let favorites = coreDataManager.savedFavoritePeopleItems
        recommendationItem = favorites.randomElement()
    }
    
    func getRecommendations() async {
        showProgressView = true
        if recommendationItem != nil {
            if let credits = await movieDataService.fetchMovieCreditsFor(personID: recommendationItem!.id) {
                let castCredits = credits.cast
                let detailsArray: [ItemDetails] = await withTaskGroup(of: ItemDetails.self, body: { group in
                    var items = [ItemDetails]()
                    for credit in castCredits {
                        group.addTask {
                            if let item = await self.movieDataService.fetchMovieDetails(id: credit.id) {
                                return item
                            } else {
                                return ItemDetails.example
                            }
                        }
                    }
                    for await taskResult in group {
                        if taskResult.id > 1 {
                            items.append(taskResult)
                        }
                    }
                    return items
                })
                recommendations = detailsArray
            }
        }
        showProgressView = false
    }
    
    init(movieDataService: MovieDataService, coreDataManager: CoreDataManager) {
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        self._coreDataManager = ObservedObject(wrappedValue: coreDataManager)
    }
    
}
