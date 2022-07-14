//
//  FavoritePersonViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 14/07/2022.
//

import Foundation
import SwiftUI

class FavoritePersonViewModel: ObservableObject {
    @ObservedObject var movieDataService: MovieDataService
    let person: FavoriteModel
    @Published var personDetails: PersonDetails?
    @Published var url = URL(string: "")
    

    func getURL() async {
        if url == URL(string: "") {
            url = await movieDataService.getPathToProfileImageFor(id: person.id)
        }
    }
    
    func getPersonDetails() async {
        personDetails = await movieDataService.fetchPersonDetailsfor(id: person.id)
    }
    
    init(person: FavoriteModel, movieDataService: MovieDataService) {
        self.person = person
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
}
