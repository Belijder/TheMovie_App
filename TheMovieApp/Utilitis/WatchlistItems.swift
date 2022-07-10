//
//  FavoriteItems.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/03/2022.
//

import Foundation
import CoreData
import SwiftUI
import Combine

class WatchlistItems: ObservableObject {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Published var items: [ItemDetails] = []
//    var cancellables = Set<AnyCancellable>()
    
                      
    func addToWatchlist(itemId: Int) async {
        let item = await fetchItemDetails(from: itemId)
        if item != nil {
            await MainActor.run(body: {
                items.append(item!)
            })
        } else {
            return
        }
    }
    
    func addToWatchlist(item: ItemDetails) {
        //items.append(item)
        coreDataManager.addWatchlistEntity(id: item.id, title: item.title, posterPath: item.posterPath ?? "", voteAverage: item.voteAverage)
    }
    
    func removeFromWatchlist(item: ItemDetails) {
//        if items.contains(where: { element in
//            if element.id == item.id {
//                return true
//            } else {
//                return false
//            }
//        }) {
//            if let index = items.firstIndex(of: item) {
//                items.remove(at: index)
//            }
//        } else {
//            return
//        }
        coreDataManager.removeWatchlistEntity(id: item.id)
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
    
//    func addWatchListSubscriber() {
//        $coreDataManager.savedWatchlistItems
//            .sink { value in
//                self.items = value
//            }
//    }

}
