//
//  RatingsView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 16/07/2022.
//

import SwiftUI

struct RatingsView: View {
    
    @ObservedObject var movieDataService: MovieDataService
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(coreDataManager.savedUserRatingsItems) { movie in
                        HorizontalStyleMovieCell(id: movie.id, title: movie.title, releaseDate: movie.releaseDate, voteAverage: movie.voteAverage, userRating: movie.userRate, ratingDate: movie.ratingDate, posterPath: movie.posterPath, runtime: movie.runtime, movieDataService: movieDataService)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .navigationBarTitle(Text("Ratings"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(movieDataService: MovieDataService) {
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView(movieDataService: MovieDataService())
    }
}
