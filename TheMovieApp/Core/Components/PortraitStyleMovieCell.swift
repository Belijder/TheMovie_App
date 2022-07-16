//
//  PortraitStyleMovieCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 28/02/2022.
//

import SwiftUI
import AVKit

struct PortraitStyleMovieCell: View {
    
    init(movie: ItemDetails, movieDataService: MovieDataService) {
        self.movie = movie
        _movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
    
    let movie: ItemDetails
    @ObservedObject var movieDataService: MovieDataService
    @State private var url = URL(string: "")
    
    var body: some View {
            ZStack {
                VStack(spacing: 0) {
                    AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .frame(width: 160, height: 240)
                                .scaledToFill()
                    } placeholder: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.secondary)
                                .frame(width: 160, height: 240)
                            ProgressView()
                        }
                        
                    }
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(alignment: .center, spacing: 5) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                                Text("\(String(format: "%.1f", movie.voteAverage))")
                                    .foregroundColor(.primary)
                                    .font(.footnote)
                            }
                            Text(movie.title)
                                .foregroundColor(.primary)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                
                        }
                        .padding(.leading, 8)
                        .padding(.vertical, 8)
                        Spacer()
                    }
                    .frame(width: 160)
                    .background(alignment: .center) {
                        Rectangle()
                            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                            .foregroundColor(UITraitCollection.current.userInterfaceStyle == .dark ? Color.black : Color.white)
                    }
                }
                
                WatchlistCornerButton(item: WatchlistModel(id: movie.id, title: movie.title, posterPath: movie.posterPath ?? "", voteAverage: movie.voteAverage))
                
            }
            .task {
                url = await movieDataService.makePosterImageURL(movieId: movie.id)
            }
        
        
    }
}

struct PortraitStyleMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        PortraitStyleMovieCell(movie: ItemDetails.example, movieDataService: MovieDataService())
    }
}


