//
//  WatchlistModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 10/07/2022.
//

import Foundation

struct WatchlistModel: Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let posterPath: String
    let voteAverage: Double
}
