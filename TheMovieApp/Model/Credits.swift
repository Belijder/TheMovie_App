//
//  Credits.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 21/03/2022.
//

import Foundation
import SwiftUI

struct Credits: Codable, Identifiable, Equatable {
    
    let id: Int
    let cast: [CastMember]
    let crew: [CrewMember]
    
    static let example = Credits(id: 1, cast: [], crew: [])
}

struct CastMember: Codable, Identifiable, Equatable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castId: Int
    let character: String
    let creditId: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
    }
}

struct CrewMember: Codable, Identifiable, Equatable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let creditId: String
    let department: String
    let job: String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditId = "credit_id"
        case department
        case job
    }
}
