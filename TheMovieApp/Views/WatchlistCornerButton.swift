//
//  FavoriteCornerButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/03/2022.
//

import SwiftUI

struct WatchlistCornerButton: View {
    
    @EnvironmentObject var watchlistItems: WatchlistItems
    
    let item: PopularMovie
    
    var body: some View {
        VStack {
            HStack {
                if watchlistItems.items.contains(item) {
                    Button {
                        watchlistItems.removeFromWatchlist(item: item)
                    } label: {
                        ZStack {
                            Image(systemName: "rectangle.portrait.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.yellow)
                            Image(systemName: "checkmark")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }

                } else {
                    Button  {
                        watchlistItems.addToWatchlist(item: item)
                    } label: {
                        ZStack {
                            Image(systemName: "rectangle.portrait.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.black.opacity(0.3))
                            Image(systemName: "plus")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer()
            }
            Spacer()
        }
    }
}


struct FavoriteCornerButton_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistCornerButton(item: PopularMovie.example)
    }
}
