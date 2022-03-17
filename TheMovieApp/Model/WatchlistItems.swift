//
//  FavoriteItems.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/03/2022.
//

import Foundation

class WatchlistItems: ObservableObject {
    
    @Published var items: [PopularMovie] = []
                      
    func addToWatchlist(item: PopularMovie) {
        items.append(item)
    }
    
    func removeFromWatchlist(item: PopularMovie) {
        if items.contains(where: { element in
            if element.id == item.id {
                return true
            } else {
                return false
            }
        }) {
            if let index = items.firstIndex(of: item) {
                items.remove(at: index)
            }
        } else {
            return
        }
    }
    
    func addItemToArray(id: Int) {
        
    }
    
    func checkIfItemIsInArray(id: Int) -> Bool {
        items.contains(where: { element in
            if element.id == id {
                return true
            } else {
                return false
            }
        })
    }
}
