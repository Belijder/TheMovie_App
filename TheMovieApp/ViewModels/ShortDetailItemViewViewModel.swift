//
//  ShortDetailItemViewViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 09/03/2022.
//

import Foundation

class ShortDetailItemViewViewModel: ObservableObject {
    
    var itemIDs = [Int]()
    
    @Published var items: Result<[ItemDetails], Error>?
    
    func fetchitems(for ids: [Int]) async -> Result<[ItemDetails], Error> {
        do {
            var results = [ItemDetails]()
            
            for id in ids {
                let url = FetchManager.shared.makeURL(with: .details, id: id)
                let response = try await URLSession.shared.decode(ItemDetails.self, from: url)
                results.append(response)
            }
            return .success(results)
        } catch {
            print(error)
            return .failure(error)
        }
    }
}
