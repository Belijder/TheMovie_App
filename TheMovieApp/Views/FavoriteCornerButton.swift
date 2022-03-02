//
//  FavoriteCornerButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/03/2022.
//

import SwiftUI

struct FavoriteCornerButton: View {
    
    @EnvironmentObject var favoriteItems: FavoriteItems
    
    let itemId: Int
    
    var body: some View {
        VStack {
            HStack {
                if favoriteItems.arrayOfIds.contains(itemId) {
                    Button {
                        favoriteItems.removeFromFavorite(id: itemId)
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
                        favoriteItems.addToFavorite(id: itemId)
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
        FavoriteCornerButton(itemId: 634649)
    }
}
