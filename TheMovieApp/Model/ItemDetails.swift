//
//  ItemDetails.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 07/03/2022.
//

import Foundation

struct ItemDetails: Decodable, Identifiable, Equatable {
    
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [Country]
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [Language]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = ""
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    static let example = ItemDetails(adult: false, backdropPath: "BackdropPath", budget: 3000000, genres: [Genre(id: 1, name: "Horror")], homepage: "", id: 1, originalLanguage: "England", originalTitle: "Superman", overview: "Superman is best movie ever. Oh wait this is not true. The best movie is Harry Potter", productionCompanies: [ProductionCompany(name: "Warner Bros", id: 1, logoPath: "logoPath", originCountry: "USA")], productionCountries: [Country(isoCode: "es_EN", name: "England")], releaseDate: "20.12.2022", revenue: 10000000, runtime: 134, spokenLanguages: [Language(isoCode: "en_EN", name: "England")], status: "Cancelled", tagline: "tagline", title: "Superman", video: false, voteAverage: 7.3, voteCount: 3245)
    
    
}

struct Genre: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
}

struct ProductionCompany: Decodable, Identifiable, Equatable {
    let name: String
    let id: Int
    let logoPath: String?
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
        
    }
}

struct Country: Decodable, Equatable {
    let isoCode: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case isoCode = "iso_3166_1"
        case name
    }
}

struct Language: Decodable, Equatable {
    let isoCode: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case isoCode = "iso_639_1"
        case name
    }
}
