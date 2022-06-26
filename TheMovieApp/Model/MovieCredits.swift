//
//  MovieCredits.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 25/06/2022.
//

import Foundation

struct MovieCredits: Codable {
    let cast: [Cast]
    let crew: [Crew]
    let id: Int
}

struct Cast: Codable, Identifiable, Equatable {
    let character, creditID, releaseDate: String
    let voteCount: Int
    let video, adult: Bool
    let voteAverage: Double
    let title: String
    let genreIDS: [Int]
    let originalLanguage, originalTitle: String
    let popularity: Double
    let id: Int
    let backdropPath: String?
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case character
        case creditID = "credit_id"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case video, adult
        case voteAverage = "vote_average"
        case title
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity, id
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
    }
}

struct Crew: Codable, Identifiable, Equatable {
    let id: Int
    let department, originalLanguage, originalTitle, job: String
    let overview: String
    let voteCount: Int
    let video: Bool
    let posterPath: String?
    let backdropPath: String?
    let title: String
    let popularity: Double
    let genreIDS: [Int]
    let voteAverage: Double
    let adult: Bool
    let releaseDate, creditID: String

    enum CodingKeys: String, CodingKey {
        case id, department
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case job, overview
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title, popularity
        case genreIDS = "genre_ids"
        case voteAverage = "vote_average"
        case adult
        case releaseDate = "release_date"
        case creditID = "credit_id"
    }
}
