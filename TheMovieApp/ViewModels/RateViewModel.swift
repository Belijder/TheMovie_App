//
//  RateViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 29/06/2022.
//

import Foundation
import SwiftUI

class RateViewModel: ObservableObject {
    @ObservedObject var movieDataService: MovieDataService
    let movie: ItemDetails
    
    init(movieDataService: MovieDataService, movie: ItemDetails) {
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
        self.movie = movie
    }
}
