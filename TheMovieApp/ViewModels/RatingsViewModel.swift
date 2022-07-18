//
//  RatingsViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 18/07/2022.
//

import Foundation
import SwiftUI
import Combine

class RatingsViewModel: ObservableObject {
    @ObservedObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    var cancellables = Set<AnyCancellable>()
    @Published var ratedMovies: [RatedItemModel] = []
    
    init(coreDataManager: CoreDataManager, movieDataService: MovieDataService) {
        _coreDataManager = ObservedObject(wrappedValue: coreDataManager)
        _movieDataService = ObservedObject(wrappedValue: movieDataService)
        setSubscriber()
    }
    
    func setSubscriber() {
        coreDataManager.$savedUserRatingsItems
            .sink { [weak self] value in
                self?.ratedMovies = value
            }
            .store(in: &cancellables)
    }
}
