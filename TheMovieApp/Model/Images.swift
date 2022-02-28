//
//  Images.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 27/02/2022.
//

import Foundation

struct Images: Decodable {
    let backdrops: [backdrop]
    let posters: [poster]
}

struct backdrop: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case isoCode = "iso_639_1"
    }
    
    let aspectRatio: Double
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let isoCode: String?
    
}

struct poster: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case isoCode = "iso_639_1"
    }
    
    let aspectRatio: Double
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let isoCode: String?
}
