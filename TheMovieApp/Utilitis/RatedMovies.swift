//
//  RatedMovies.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 29/06/2022.
//

import Foundation

class RatedMovies: ObservableObject {
    @Published var items: [ItemDetails] = []
    
//    func addToRated(itemId: Int) async {
//        let item = await fetchItemDetails(from: itemId)
//        if item != nil {
//            await MainActor.run(body: {
//                items.append(item!)
//            })
//        } else {
//            return
//        }
//    }
    
    func addToRated(movie: ItemDetails, rating: Int) {
        var ratedMovie = movie
        ratedMovie.userRating = rating
            
        if checkIfItemIsInArray(id: movie.id) {
            replaceMovieInArray(movie: movie, newMovie: ratedMovie)
            } else {
                addNewMovieToArray(item: ratedMovie)
            }
    }
    
    private func addNewMovieToArray(item: ItemDetails) {
        items.append(item)
    }
    
    private func replaceMovieInArray(movie: ItemDetails, newMovie: ItemDetails) {
        if let i = items.firstIndex(where: { $0.id == movie.id }) {
            items[i] = newMovie
        }
    }
    
    func removeFromRated(item: ItemDetails) {
        if items.contains(where: { element in
            if element.id == item.id {
                return true
            } else {
                return false
            }
        }) {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items.remove(at: index)
            }
        } else {
            return
        }
    }
    
//    func fetchItemDetails(from id: Int) async -> ItemDetails? {
//        if let url = FetchManager.shared.makeURL(with: .details, id: id) {
//            do {
//                let response = try await URLSession.shared.decode(ItemDetails.self, from: url)
//                return response
//            } catch {
//                print(error.localizedDescription)
//                return nil
//            }
//        } else {
//            return nil
//        }
//    }
    
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
