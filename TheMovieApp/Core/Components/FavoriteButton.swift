//
//  FavoriteButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/06/2022.
//

import SwiftUI

struct FavoriteButton: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    
    //let person: PersonDetails
    let id: Int
    let name: String
    let profilePath: String
    let placeOfBirth: String
    
    var body: some View {
        if id > 0 {
            if coreDataManager.savedFavoritePeopleItems.contains(where: { $0.id == id }) {
                Button {
                    coreDataManager.removeFavoritePeopleEntity(id: id)
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
                    coreDataManager.addFavoritePeopleEntity(id: id, name: name, profilePath: profilePath, placeOfBirth: placeOfBirth)
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
        FavoriteButton(id: dev.person.id, name: dev.person.name, profilePath: dev.person.profilePath, placeOfBirth: dev.person.placeOfBirth)
    }
}
}
