//
//  FavoriteCornerButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/03/2022.
//

import SwiftUI

struct WatchlistCornerButton: View {
    
    @EnvironmentObject var watchlistItems: WatchlistItems
    
    let itemId: Int
    
    var body: some View {
        VStack {
            HStack {
                if watchlistItems.arrayOfIds.contains(itemId) {
                    Button {
                        watchlistItems.removeFromFavorite(id: itemId)
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
                        watchlistItems.addToFavorite(id: itemId)
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
        WatchlistCornerButton(itemId: 634649)
    }
}
