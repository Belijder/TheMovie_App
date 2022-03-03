//
//  FavoriteItems.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/03/2022.
//

import Foundation

class WatchlistItems: ObservableObject {
    
    @Published var arrayOfIds: [Int] = []
                      
    func addToFavorite(id: Int) {
        arrayOfIds.append(id)
    }
    
    func removeFromFavorite(id: Int) {
        if arrayOfIds.contains(id) {
            if let index = arrayOfIds.firstIndex(of: id) {
                arrayOfIds.remove(at: index)
            }
        } else {
            return
        }
    }
}
