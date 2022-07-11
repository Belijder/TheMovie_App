//
//  FavoriteButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/06/2022.
//

import SwiftUI

struct FavoriteButton: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    let person: PersonDetails
    
    var body: some View {
        if person.id > 0 {
            if coreDataManager.savedFavoritePeopleItems.contains(where: { $0.id == person.id }) {
                Button {
                    coreDataManager.removeFavoritePeopleEntity(id: person.id)
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
                    coreDataManager.addFavoritePeopleEntity(id: person.id, name: person.name, profilePath: person.profilePath, placeOfBirth: person.placeOfBirth)
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
