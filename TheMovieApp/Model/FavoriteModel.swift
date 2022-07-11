//
//  FavoriteModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/07/2022.
//

import Foundation

struct FavoriteModel: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let placeOfBirth: String
    let profilePath: String
}
