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
    @Published var savedWatchlistItems: [WatchlistModel] = []
    var movieDataService = MovieDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "SavedDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA> \(error)")
            }
        }
        addWatchListSubscriber()
        savedWatchlistEntities = fetchWatchlistEntities()
    }
    
    
    func fetchWatchlistEntities() -> [WatchListEntity] {
        let request = NSFetchRequest<WatchListEntity>(entityName: "WatchListEntity")
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching WatchlistEntities. \(error)")
            return []
        }
    }
    
    func addWatchlistEntity(id: Int, title: String, posterPath: String, voteAverage: Double) {
        let newEntity = WatchListEntity(context: container.viewContext)
        newEntity.id = Int64(id)
        newEntity.title = title
        newEntity.voteAverage = voteAverage
        newEntity.posterPath = posterPath
        saveData()
        savedWatchlistEntities = fetchWatchlistEntities()
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
        savedWatchlistEntities = fetchWatchlistEntities()
    }
    
    func removeAllEntities() {
        let fetchRequest = NSFetchRequest<WatchListEntity>(entityName: "WatchListEntity")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try container.viewContext.fetch(fetchRequest) as [NSManagedObject]
            for item in items {
                container.viewContext.delete(item)
            }
        } catch let error {
            print("Error when try to delete. \(error)")
        }
        saveData()
        
    }
    
    func addWatchListSubscriber() {
        $savedWatchlistEntities
            .map { (entities) -> [WatchlistModel] in
                var movies: [WatchlistModel] = []
                for ent in entities {
                    let newItem = WatchlistModel(
                        id: Int(ent.id),
                        title: ent.title ?? "Unknown",
                        posterPath: ent.posterPath ?? "",
                        voteAverage: ent.voteAverage)
                    movies.append(newItem)
                }
                return movies
            }
            .sink { value in
                self.savedWatchlistItems = value
            }
            .store(in: &cancellables)
    }
}
