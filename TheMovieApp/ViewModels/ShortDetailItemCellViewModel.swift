//
//  ShortDetailItemCellViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 21/07/2022.
//

import Foundation
import SwiftUI

class ShortDetailItemCellViewModel: ObservableObject {
    @ObservedObject var movieDataService: MovieDataService
    let topCastArray: [CastMember]
    let backdropPath: String?
    let credits: Credits
    let item: ItemDetails
    let reviews: Reviews
    
    init(topCastArray: [CastMember], backdropPath: String?, credits: Credits, item: ItemDetails, reviews: Reviews, movieDataService: MovieDataService) {
        self.topCastArray = topCastArray
        self.backdropPath = backdropPath
        self.credits = credits
        self.item = item
        self.reviews = reviews
        self._movieDataService = ObservedObject(wrappedValue: movieDataService)
    }
}
