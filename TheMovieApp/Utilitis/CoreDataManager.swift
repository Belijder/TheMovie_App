//
//  CoreData.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/07/2022.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class CoreDataManager: ObservableObject {
    
    @Published var savedWatchlistEntities: [WatchListEntity] = []
    var movieDataService = MovieDataService()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "SavedDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA> \(error)")
            }
        }
        fetchWatchlistEntities()
    }
    
    func fetchWatchlistEntities() {
        let request = NSFetchRequest<WatchListEntity>(entityName: "WatchListEntity")
        do {
            savedWatchlistEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching WatchlistEntity. \(error)")
        }
    }
    
    func addWatchlistEntity(id: Int) {
        let newEntity = WatchListEntity(context: container.viewContext)
        newEntity.id = Int64(id)
        newEntity.date = Date.now
        saveData()
        fetchWatchlistEntities()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func removeWatchlistEntity(id: Int) {
        guard let entity = savedWatchlistEntities.first(where: { $0.id == Int64(id) }) else { return }
        container.viewContext.delete(entity)
        saveData()
        fetchWatchlistEntities()
        
    }
    
}
