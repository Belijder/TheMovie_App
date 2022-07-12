//
//  WatchlistViewSegment.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 03/03/2022.
//

import SwiftUI

struct WatchlistViewSegment: View {
    
    init(movieDataService: MovieDataService) {
        _movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    
    var body: some View {
        VStack(spacing: 10) {
            HeadLineRow(context: "From your Watchlist")
                .padding(.leading, 8)
            if coreDataManager.savedWatchlistItems.isEmpty {
                VStack {
                    ZStack {
                        Image(systemName: "rectangle.portrait.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.black.opacity(0.3))
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(.white)
                    }.padding(.vertical, 15)
                    
                    Text("No available releases")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                    
                    Text("Add more shows and movies to keep track of what you want to watch")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 10)
                    
                    Button {
                        //action here
                    } label: {
                        Text("Browse popular movies")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .padding(20)
                    }

                    
                }
                .background(alignment: .center) {
                    Color.secondary.opacity(0.2)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 8)
            } else {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(coreDataManager.savedWatchlistItems) { movie in
                            WatchlistPosterView(movie: movie, movieDataService: movieDataService)
                        }
                    }
                    .padding(.leading, 8)
                }
            }
            
        }
        .padding(.init(top: 5, leading: 0, bottom: 15, trailing: 0))
        .background(alignment: .center) {
            Color.secondary.opacity(0.1)
        }
    }
}

struct WatchlistViewSegment_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistViewSegment(movieDataService: MovieDataService())
    }
}
