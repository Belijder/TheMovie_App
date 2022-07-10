//
//  FavoriteCornerButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/03/2022.
//

import SwiftUI

struct WatchlistCornerButton: View {
    
    @EnvironmentObject var watchlistItems: WatchlistItems
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    let item: WatchlistModel
    
    var body: some View {
        VStack {
            HStack {
                if coreDataManager.savedWatchlistItems.contains(item) {
                    Button {
                        coreDataManager.removeWatchlistEntity(id: item.id)
                        print(coreDataManager.savedWatchlistEntities.count)
                    } label: {
                        ZStack {
                            WatchlistShape()
                                .frame(width: UIScreen.main.bounds.width / 13, height: UIScreen.main.bounds.height / 19)
                                .foregroundColor(Color.yellow)
                                .overlay(
                                    WatchlistShape()
                                        .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                                )
                            
                            Image(systemName: "checkmark")
                                .font(.headline)
                                .foregroundColor(.white)
                                .offset(y: -(UIScreen.main.bounds.height / 23 / 7))
                        }
                    }

                } else {
                    Button  {
                        coreDataManager.addWatchlistEntity(id: item.id, title: item.title, posterPath: item.posterPath, voteAverage: item.voteAverage)
                        print(coreDataManager.savedWatchlistEntities.count)
                    } label: {
                        ZStack {
                            WatchlistShape()
                                .frame(width: UIScreen.main.bounds.width / 13, height: UIScreen.main.bounds.height / 19)
                                .foregroundColor(Color.black.opacity(0.3))
                                .overlay(
                                    WatchlistShape()
                                        .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                                )
                                
                            Image(systemName: "plus")
                                .font(.headline)
                                .foregroundColor(.white)
                                .offset(y: -(UIScreen.main.bounds.height / 23 / 9))
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
        WatchlistCornerButton(item: dev.watchlistModel)
    }
}
