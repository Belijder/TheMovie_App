//
//  PopularMovies.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/02/2022.
//

import Foundation

struct PopularMovies: Decodable {
    let page: Int
    let results: [PopularMovie]
}

struct PopularMovie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case video
    }
    
    let posterPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let title: String
    let backdropPath: String
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    let video: Bool
    
    static let example = PopularMovie(posterPath: "/lFSSLTlFozwpaGlO31OoUeirBgQ.jpg", adult: false, overview: "The most dangerous former operative of the CIA is drawn out of hiding to uncover hidden truths about his past.", releaseDate: "2016-07-27", genreIds: [28, 53], id: 324668, originalTitle: "Jason Bourne", title: "Jason Bourne", backdropPath: "/AoT2YrJUJlg5vKE3iMOLvHlTd3m.jpg", popularity: 30.690177, voteCount: 649, voteAverage: 5.25, video: false)
}
