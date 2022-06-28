//
//  SearchMovieViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 27/06/2022.
//

import Foundation
import SwiftUI
import Combine

class SearchMovieViewModel: ObservableObject {
    
    @ObservedObject var movieDataService: MovieDataService
    @Published var query = ""
    @Published var searchedMovies: [SearchedMovie] = []
    //var cancellables: Set<AnyCancellable>
    @Published var isSearching = false
    
    init(movieDataService: MovieDataService) {
        self.movieDataService = movieDataService
        //addQuerySubscriber()
    }
    
    func getResultsOfSearchForQuery(query: String) async {
        searchedMovies = await movieDataService.searchForAMovieBasedOn(query: query)
    }
    
//    func getItemDetailsFor(movie: SearchedMovie) -> ItemDetails? {
//        Task {
//            if let itemDetails = await movieDataService.fetchMovieDetails(id: movie.id) {
//                return itemDetails
//            } else {
//                return nil
//            }
//        }
//    }
    
//  COMBINE WAY TO SEARCH
//    func addQuerySubscriber() {
//        $query
//            .debounce(for: 0.8, scheduler: DispatchQueue.main)
//            .removeDuplicates()
//            .handleEvents(receiveOutput: { output in
//                self.isSearching = true
//            })
//            .flatMap { value in
//                Future { promise in
//                    Task {
//                        let result = await self.movieDataService.searchForAMovieBasedOn(query: value)
//                        promise(.success(result))
//                    }
//                }
//            }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//            .handleEvents(receiveOutput: { output in
//                self.isSearching = false
//            })
//            .assign(to: &$searchedMovies)
//    }
    
}
