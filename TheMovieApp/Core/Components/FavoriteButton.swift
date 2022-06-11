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
        VStack {
            Spacer()
            HStack {
                if favoritePersons.items.contains(person) {
                    Button {
                        favoritePersons.removeFromFavorite(item: person)
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.headline)
                            .foregroundColor(.yellow)
                            .background(Color.black.opacity(0.3))
                            .padding(5)
                            .clipShape(Circle())
                            .padding()
                    }
                } else {
                    Button  {
                        Task {
                            favoritePersons.addToFavorite(item: person)
                        }
                    } label: {
                        Image(systemName: "heart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.3))
                            .padding(5)
                            .clipShape(Circle())
                            .padding()
                    }
                }

                Spacer()
            }
        }
    }


struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(person: dev.person)
    }
}
}
