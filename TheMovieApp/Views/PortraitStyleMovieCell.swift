//
//  PortraitStyleMovieCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 28/02/2022.
//

import SwiftUI

struct PortraitStyleMovieCell: View {
    
    let movie: PopularMovie
    @State private var url = URL(string: "")
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 150)
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(alignment: .center, spacing: 5) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                            Text("\(String(format: "%.1f", movie.voteAverage))")
                                .foregroundColor(.primary)
                                .font(.caption)
                        }
                        Text(movie.title)
                            .foregroundColor(.primary)
                            .font(.caption)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            
                    }
                    .padding(.leading, 4)
                    .padding(.vertical, 8)
                    Spacer()
                }
                .frame(width: 100)
                .background(Color.secondary.opacity(0.1))
                
            }
        }.task {
            url = await FetchManager.shared.makePosterImageURL(movieId: movie.id)
        }
    }
}

struct PortraitStyleMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        PortraitStyleMovieCell(movie: PopularMovie.example)
    }
}
