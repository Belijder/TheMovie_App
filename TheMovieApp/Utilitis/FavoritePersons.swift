//
//  FavoritePersons.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/06/2022.
//

import Foundation

class FavoritePersons: ObservableObject {
    @Published var items: [PersonDetails] = []
    
    func addToFavorite(item: PersonDetails) {
        self.items.append(item)
    }
    
    func addToFavorite(id: Int) async {
        let item = await fetchPersonDetailsfor(id: id)
        if let item = item {
            await MainActor.run(body: {
                self.items.append(item)
            })
        } else {
            return
        }
    }
    
    func fetchPersonDetailsfor(id: Int) async -> PersonDetails? {
        if let url = FetchManager.shared.makeURL(with: .personDetails, id: id) {
            do {
                let response = try await URLSession.shared.decode(PersonDetails.self, from: url)
                return response
            } catch let error {
                print("\(error.localizedDescription) ⚡️")
                return nil
            }
        } else {
            return nil
        }
    }
    
    func removeFromFavorite(item: PersonDetails) {
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
