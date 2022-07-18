//
//  RatingsView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 16/07/2022.
//

import SwiftUI

struct RatingsView: View {
    @StateObject var vm: RatingsViewModel
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vm.ratedMovies) { movie in
                        HorizontalStyleMovieCell(id: movie.id, title: movie.title, releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, userRating: movie.userRate, ratingDate: movie.ratingDate, posterPath: movie.posterPath, runtime: movie.runtime, movieDataService: vm.movieDataService)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .navigationBarTitle(Text("Ratings"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(coreDataManager: CoreDataManager, movieDataService: MovieDataService) {
        _vm = StateObject(wrappedValue: RatingsViewModel(coreDataManager: coreDataManager, movieDataService: movieDataService))
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView(coreDataManager: CoreDataManager(), movieDataService: MovieDataService())
    }
}
