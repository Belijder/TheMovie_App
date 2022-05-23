//
//  MainViewViewModel.swift
//  TheMovieApp
//
//  Created by Jakub Zajda on 26/02/2022.
//

import Foundation
import SwiftUI

@MainActor class MainViewViewModel: ObservableObject {
    
    @Published var popularMovies: Result<[ItemDetails], Error>?
    
    @Published var popularMoviesIDs = [Int]()
    
    func fetchPopularMovies() async -> Result<[ItemDetails], Error> {
        
        var result = [ItemDetails]()
        var movies = [PopularMovie]()
        
        //Fetching PopularMovie array
        do {
            let url = FetchManager.shared.makeURL(with: .popularMovies, id: 1)
            let response = try await URLSession.shared.decode(PopularMovies.self, from: url)
            movies = response.results
        } catch {
            print("Error when try to fetch PopularMovie array: \(error)")
            return .failure(error)
        }
        
        //Fetching ItemDetails Array from popularMovie array
        for movie in movies {
            do {
                let url = FetchManager.shared.makeURL(with: .details, id: movie.id)
                let response = try await URLSession.shared.decode(ItemDetails.self, from: url)
                result.append(response)
                
            } catch {
                print("Error when try to fetch ItemDetails array: \(error)")
                return .failure(error)
            }
        }
        
        return .success(result)
    }
    
    func getPopularMoviesIDs() {
        popularMoviesIDs = []
        switch popularMovies {
        case .success(let movies):
            for movie in movies {
                popularMoviesIDs.append(movie.id)
            }
        case .failure(_):
            return popularMoviesIDs = []
        case .none:
            return popularMoviesIDs = []
        }
    }

    
    init() {
        Task {
            popularMovies = await fetchPopularMovies()
        }
    }
}
