//
//  AllCastViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/06/2022.
//

import Foundation

class AllCastViewModel: ObservableObject {
    let cast: [CastMember]
    let crew: [CrewMember]
    let date: String
    
    init(cast: [CastMember], crew: [CrewMember], date: String) {
        self.cast = cast
        self.crew = crew
        self.date = date
    }
    
}
