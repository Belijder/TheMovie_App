//
//  RatedItemModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/07/2022.
//

import Foundation

struct RatedItemModel: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let posterPath: String
    let userRate: Int
    let runtime: Int
    let releaseDate: String
    let voteAverage: Double
    let ratingDate: Date
    
    
}
