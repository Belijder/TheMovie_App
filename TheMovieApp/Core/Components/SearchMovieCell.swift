//
//  SearchMovieCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 27/06/2022.
//

import SwiftUI

struct SearchMovieCell: View {
    
    @ObservedObject var movieDataService: MovieDataService
    let movie: SearchedMovie
    @State private var url = URL(string: "")
    @StateObject var vm: SearchMovieCellViewModel
    
    init(movieDataService: MovieDataService, movie: SearchedMovie) {
        self.movieDataService = movieDataService
        self.movie = movie
        self._vm = StateObject(wrappedValue: SearchMovieCellViewModel(movieDataService: movieDataService, id: movie.id))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if vm.complexDataForMovie.isEmpty {
                label
            } else {
                NavigationLink {
                    LongDetailView(movieDataService: movieDataService, topCastArray: vm.complexDataForMovie[0].topCastArray, backdropPath: vm.complexDataForMovie[0].backdropPath, credits: vm.complexDataForMovie[0].credits, itemDetails: vm.complexDataForMovie[0].itemDetails, reviews: vm.complexDataForMovie[0].reviews)
                } label: {
                    label
                }
            }
        }
        .task {
            url = await movieDataService.makePosterImageURL(movieId: movie.id)
        }
        .navigationBarHidden(true)
    }
    
}

struct SearchMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovieCell(movieDataService: MovieDataService(), movie: dev.searchedMovie)
    }
}

extension SearchMovieCell {
    private var label: some View {
        HStack(spacing: 10) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: 50, height: 75)
                    .scaledToFill()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.secondary)
                        .frame(width: 50, height: 75)
                    Image(systemName: "photo.fill")
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                if movie.releaseDate != nil {
                    Text(movie.releaseDate!.prefix(4))
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            if movie.voteAverage > 0 {
                VoteAverageView(voteAverage: movie.voteAverage, voteCount: nil)
            }
        }
    }
}
