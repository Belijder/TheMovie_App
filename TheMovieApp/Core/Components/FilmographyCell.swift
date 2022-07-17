//
//  FilmographyCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 22/06/2022.
//

import SwiftUI

struct FilmographyCell: View {
    @ObservedObject var movieDataservice: MovieDataService
    let movie: ItemDetails
    @State private var url = URL(string: "")
    let character: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .frame(width: 90, height: 135)
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.secondary)
                            .frame(width: 90, height: 135)
                        Image(systemName: "photo")
                            .foregroundColor(.primary)
                            .font(.title)
                    }
                }
                Text(movie.title)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(character)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Text(movie.releaseDate.prefix(4))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            .frame(width: 90)
        }
        .padding(5)
        .task {
            await url = movieDataservice.makePosterImageURL(movieId: movie.id)
        }
    }
}

struct FilmographyCell_Previews: PreviewProvider {
    static var previews: some View {
        FilmographyCell(movieDataservice: MovieDataService(), movie: ItemDetails.example, character: "Character Name")
    }
}
