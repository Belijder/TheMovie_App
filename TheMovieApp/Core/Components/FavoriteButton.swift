//
//  FavoriteButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/06/2022.
//

import SwiftUI

struct FavoriteButton: View {
    
    @EnvironmentObject var favoritePersons: FavoritePersons
    
    let person: PersonDetails
    
    var body: some View {
        if person.id > 0 {
            if favoritePersons.items.contains(person) {
                Button {
                    favoritePersons.removeFromFavorite(item: person)
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.black.opacity(0.5))
                        Image(systemName: "heart.fill")
                            .font(.headline)
                            .foregroundColor(.yellow)
                    }
                    .padding(5)
                }
            } else {
                Button  {
                    Task {
                        favoritePersons.addToFavorite(item: person)
                    }
                } label: {
                    ZStack {
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.black.opacity(0.5))
                        Image(systemName: "heart")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(5)
                }
            }
        }
        
    }


struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(person: dev.person)
    }
}
}
