//
//  Poster.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 14/07/2022.
//

import SwiftUI

struct PosterInRatedBanner: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    @State var url = URL(string: "")
    let movieID: Int
    
    var body: some View {
        ZStack {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondary)
                        .frame(width: 60, height: 90)
                    Image(systemName: "photo.fill")
                        .foregroundColor(.primary)
                }
            }
        }
        .task {
            url = await movieDataService.makePosterImageURL(movieId: movieID)
        }

    }
}

struct Poster_Previews: PreviewProvider {
    static var previews: some View {
        PosterInRatedBanner(movieDataService: MovieDataService(), movieID: dev.itemDetails.id)
    }
}
