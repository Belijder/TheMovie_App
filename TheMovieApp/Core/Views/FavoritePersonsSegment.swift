//
//  FavoritePersonsSegment.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 14/07/2022.
//

import SwiftUI

struct FavoritePersonsSegment: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    
    let persons: [FavoriteModel]
    
    var body: some View {
        VStack(spacing: 10) {
            HeadLineRow(context: "Your favorite actors")
                .padding(.leading, 8)
            if !coreDataManager.savedFavoritePeopleItems.isEmpty {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 5) {
                        ForEach(coreDataManager.savedFavoritePeopleItems) { person in
                            FavoritePersonView(person: person, movieDataService: movieDataService)
                        }
                    }
                    .padding(.leading, 8)
                }
            } else {
                //Nie ma zapisanych
            }
        }
        .padding(.init(top: 5, leading: 0, bottom: 15, trailing: 0))
        .background(alignment: .center) {
            Color.secondary.opacity(0.1)
        }
    }
    
    init(movieDataService: MovieDataService, persons: [FavoriteModel]) {
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        self.persons = persons
    }
}

struct FavoritePersonsSegment_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePersonsSegment(movieDataService: MovieDataService(), persons: [FavoriteModel(id: dev.person.id, name: dev.person.name, placeOfBirth: dev.person.placeOfBirth, profilePath: dev.person.profilePath)])
    }
}
