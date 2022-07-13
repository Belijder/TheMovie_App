//
//  UserItemsViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 13/07/2022.
//

import Foundation
import SwiftUI
import Combine

class UserItemsViewModel: ObservableObject {
    
    init(coreDataManager: CoreDataManager, movieDataService: MovieDataService) {
        self._coreDataManager = ObservedObject(wrappedValue: coreDataManager)
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        addsubscribers()
    }
    
    @ObservedObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    var cancellables = Set<AnyCancellable>()
    
    @Published var watchlistItems = [WatchlistModel]()
    @Published var favoritePersons = [FavoriteModel]()
    @Published var ratedMovies = [RatedItemModel]()
    
    
    func addsubscribers() {
        coreDataManager.$savedWatchlistItems
            .sink { [weak self] value in
                self?.watchlistItems = value
            }
            .store(in: &cancellables)
            
        coreDataManager.$savedFavoritePeopleItems
            .sink { [weak self] value in
                self?.favoritePersons = value
            }
            .store(in: &cancellables)
        
        coreDataManager.$savedUserRatingsItems
            .sink { [weak self] value in
                self?.ratedMovies = value
            }
            .store(in: &cancellables)
        
    }
    
}



