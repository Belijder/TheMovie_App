//
//  AllCastViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/06/2022.
//

import Foundation
import SwiftUI

class AllCastViewModel: ObservableObject {
    @ObservedObject var movieDataService: MovieDataService
    let cast: [CastMember]
    let crew: [CrewMember]
    let date: String
    
    
    @Published var personsDetailsWithCharacters: [PersonDetails] = []
    
    @Published var searchText: String = ""
    
    @Published var castPersonsDetails: [PersonDetails] = []
    
    init(movieDataService: MovieDataService, cast: [CastMember], crew: [CrewMember], date: String) {
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        self.cast = cast
        self.crew = crew
        self.date = date
        Task {
            await getPersonDetailsForCast()
            makePersonDetailsWithCharacters()
        }
    }
    
    
    var filteredCast: [CastMember] {
        if searchText.isEmpty {
            return cast
        } else {
            return cast.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func findIndexForCastMember(id: Int) -> Int? {
        cast.firstIndex(where: { $0.id == id })
    }
    
    func findIndexForPersonDetails(id: Int) -> Int? {
        personsDetailsWithCharacters.firstIndex(where: { $0.id == id })
    }
    

    func getPersonDetailsForCast() async {
        for person in self.cast {
            if let details = await movieDataService.fetchPersonDetailsfor(id: person.id) {
                castPersonsDetails.append(details)
            }
        }
        print("cpd: \(castPersonsDetails.count)")
        print("cast: \(cast.count)")
    }
    
    func makePersonDetailsWithCharacters() {
        for index in 0..<castPersonsDetails.count {
            var newPerson = castPersonsDetails[index]
            newPerson.character = cast[index].character
            personsDetailsWithCharacters.append(newPerson)
        }
    }
    
    
    
    
    
}
