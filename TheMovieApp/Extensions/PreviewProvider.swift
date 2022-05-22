//
//  PreviewProvider.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/04/2022.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let castMember = CastMember(adult: false, gender: 2, id: 819, knownForDepartment: "Acting", name: "Edward Norton", originalName: "Edward Norton", popularity: 7.861, profilePath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg", castId: 4, character: "The Narrator", creditId: "52fe4250c3a36847f80149f3", order: 0)
    
//    let itemDetails = ItemDetails(adult: false, backdropPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg", budget: 63000000, genres: [Genre(id: 18, name: "Drama")], homepage: "", id: 550, originalLanguage: "en", originalTitle: "Fight Club", overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.", popularity: 0.5, posterPath: nil, productionCompanies: [ProductionCompany(name: "Regency Enterprises", id: <#T##Int#>, logoPath: <#T##String?#>, originCountry: <#T##String#>)], productionCountries: <#T##[Country]#>, releaseDate: <#T##String#>, revenue: <#T##Int#>, runtime: <#T##Int?#>, spokenLanguages: <#T##[Language]#>, status: <#T##String#>, tagline: <#T##String?#>, title: <#T##String#>, video: <#T##Bool#>, voteAverage: <#T##Double#>, voteCount: <#T##Int#>)
    
    let genre = Genre(id: 18, name: "Drama")
}
