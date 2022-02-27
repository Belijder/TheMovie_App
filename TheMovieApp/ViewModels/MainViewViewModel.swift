//
//  MainViewViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/02/2022.
//

import Foundation
import SwiftUI

@MainActor class MainViewViewModel: ObservableObject {
    
    @Published var popularMovies: Result<[PopularMovie], Error>?
    
    func fetchPopularMovies() async -> Result<[PopularMovie], Error> {
        do {
            let url = FetchManager.shared.makeURL(with: .popularMovies, id: 1)
            let response = try await URLSession.shared.decode(PopularMovies.self, from: url)
            let movies = response.results
            return .success(movies)
        } catch {
            return .failure(error)
        }
    }

    
    init() {
        Task {
            popularMovies = await fetchPopularMovies()
        }      
    }
}
