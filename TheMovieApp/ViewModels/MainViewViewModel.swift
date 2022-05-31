//
//  MainViewViewModel.swift
//  TheMovieApp
//
//  Created by Jakub Zajda on 26/02/2022.
//

import Foundation
import SwiftUI

@MainActor class MainViewViewModel: ObservableObject {
    
    @ObservedObject var movieDataService: MovieDataService
    @Published var popularMovies: [ItemDetails] = []
    @Published var popularMoviesProgressView = true
    
   // @Published var popularMoviesIDs = [Int]()
    
//    func fetchPopularMovies() async -> Result<[ItemDetails], Error> {
//
//        var result = [ItemDetails]()
//        var movies = [PopularMovie]()
//
//        //Fetching PopularMovie array
//        do {
//            let url = FetchManager.shared.makeURL(with: .popularMovies, id: 1)
//            let response = try await URLSession.shared.decode(PopularMovies.self, from: url)
//            movies = response.results
//        } catch {
//            print("Error when try to fetch PopularMovie array: \(error)")
//            return .failure(error)
//        }
//
//        //Fetching ItemDetails Array from popularMovie array
//        for movie in movies {
//            do {
//                let url = FetchManager.shared.makeURL(with: .details, id: movie.id)
//                let response = try await URLSession.shared.decode(ItemDetails.self, from: url)
//                result.append(response)
//
//            } catch {
//                print("Error when try to fetch ItemDetails array: \(error)")
//                return .failure(error)
//            }
//        }
//
//        return .success(result)
//    }
    
//    func fetchPopularMovies() async -> [PopularMovie] {
//        var movies = [PopularMovie]()
//        if let url = FetchManager.shared.makeURL(with: .popularMovies, id: nil) {
//            do {
//                let response = try await URLSession.shared.decode(PopularMovies.self, from: url)
//                movies = response.results
//            } catch {
//                print("Error when try to fetch PopularMovie array: \(error)")
//            }
//             return movies
//        } else {
//            print("Bad URL to fetch Popular Movies array: \(URLError.badURL)")
//        }
//    }
//        
//    func fetchPopularMoviesDetails(from popularMovies: [PopularMovie]) async -> [ItemDetails] {
//        var result: [ItemDetails] = []
//        for movie in popularMovies {
//            if let url = FetchManager.shared.makeURL(with: .details, id: movie.id) {
//                    do {
//                        let response = try await URLSession.shared.decode(ItemDetails.self, from: url)
//                        result.append(response)
//                        
//                    } catch {
//                        print("Error when try to fetch ItemDetails array: \(error)")
//                    }
//            } else {
//                print("Bad URL to fetch Item Details for \(movie.title), id: \(movie.id): \(URLError.badURL)")
//            }
//        }
//        return result
//    }
    
    func getPopularMovies() async {
        popularMoviesProgressView = true
        let moviesArray = await movieDataService.fetchPopularMovies()
        self.popularMovies = await movieDataService.fetchPopularMoviesDetails(from: moviesArray)
        popularMoviesProgressView = false
    }
    
    func getPopularMoviesIDs() async -> [Int] {
        return await movieDataService.fetchPopularMoviesIDs(from: popularMovies)
    }
    


    
    init(movieDataService: MovieDataService) {
        _movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
}
