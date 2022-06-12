//
//  Person.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 12/06/2022.
//

import Foundation

// MARK: - Person
struct Person: Codable {
    let id: Int
    let profiles: [Profile]
}

// MARK: - Profile
struct Profile: Codable {
    let aspectRatio: Double
    let filePath: String
    let height: Int
    let iso639_1: String?
    let voteAverage: Double
    let voteCount, width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso639_1 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
