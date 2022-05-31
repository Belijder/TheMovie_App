//
//  FavoriteItems.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/03/2022.
//

import Foundation

class WatchlistItems: ObservableObject {
    
    @Published var items: [ItemDetails] = []
                      
    func addToWatchlist(itemId: Int) async {
        let item = await fetchItemDetails(from: itemId)
        if item != nil {
            items.append(item!)
        } else {
            return
        }
    }
    
    func addToWatchlist(item: ItemDetails) {
            items.append(item)
    }
    
    func removeFromWatchlist(item: ItemDetails) {
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
    
    func fetchItemDetails(from id: Int) async -> ItemDetails? {
        if let url = FetchManager.shared.makeURL(with: .details, id: id) {
            do {
                let response = try await URLSession.shared.decode(ItemDetails.self, from: url)
                return response
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
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
