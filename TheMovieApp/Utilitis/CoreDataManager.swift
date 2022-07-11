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
    @Published var savedUserRatingsEntites: [RatedMovieEntity] = []
    @Published var savedUserRatingsItems: [RatedItemModel] = []
    @Published var savedFavoritePeopleEntities: [FavoritePeopleEntity] = []
    @Published var savedFavoritePeopleItems: [FavoriteModel] = []
    
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
        addRatedItemSubscriber()
        addWatchListSubscriber()
        addFavoriteItemsSubscriber()
        savedWatchlistEntities = fetchWatchlistEntities()
        savedUserRatingsEntites = fetchUserRatings()
        savedFavoritePeopleEntities = fetchUserFavorites()
    }
    
    //MARK: Watchlist
    
    func fetchWatchlistEntities() -> [WatchListEntity] {
        let request = NSFetchRequest<WatchListEntity>(entityName: "WatchListEntity")
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching WatchlistEntities. \(error)")
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
    
    func removeWatchlistEntity(id: Int) {
        guard let entity = savedWatchlistEntities.first(where: { $0.id == Int64(id) }) else { return }
        container.viewContext.delete(entity)
        saveData()
        savedWatchlistEntities = fetchWatchlistEntities()
    }
    
    //MARK: RatedItems
    
    func fetchUserRatings() -> [RatedMovieEntity] {
        let request = NSFetchRequest<RatedMovieEntity>(entityName: "RatedMovieEntity")
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching RatedMovieEntity. \(error)")
            return []
        }
    }
    
    func addRatedMovieEntity(id: Int, title: String, posterPath: String, rate: Int) {
        if savedUserRatingsEntites.contains(where: { $0.id == Int64(id) }) {
            guard let entity = savedUserRatingsEntites.first(where: { $0.id == Int64(id) }) else { return }
            container.viewContext.delete(entity)
            let newEntity = RatedMovieEntity(context: container.viewContext)
            newEntity.id = Int64(id)
            newEntity.title = title
            newEntity.posterPath = posterPath
            newEntity.userRating = Int16(rate)
            saveData()
            savedUserRatingsEntites = fetchUserRatings()
        } else {
            let newEntity = RatedMovieEntity(context: container.viewContext)
            newEntity.id = Int64(id)
            newEntity.title = title
            newEntity.posterPath = posterPath
            newEntity.userRating = Int16(rate)
            saveData()
            savedUserRatingsEntites = fetchUserRatings()
        }
    }
    
    func removeRatedMovieEntity(id: Int) {
        guard let entity = savedUserRatingsEntites.first(where: { $0.id == Int64(id) }) else { return }
        container.viewContext.delete(entity)
        saveData()
        savedUserRatingsEntites = fetchUserRatings()
    }
    
    //MARK: Favorites People
    
    func fetchUserFavorites() -> [FavoritePeopleEntity] {
        let request = NSFetchRequest<FavoritePeopleEntity>(entityName: "FavoritePeopleEntity")
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching FavoritePeopleEntity. \(error)")
            return []
        }
    }
    
    func addFavoritePeopleEntity(id: Int, name: String, profilePath: String, placeOfBirth: String) {
        let newEntity = FavoritePeopleEntity(context: container.viewContext)
        newEntity.id = Int32(id)
        newEntity.name = name
        newEntity.profilePath = profilePath
        newEntity.placeOfBirth = placeOfBirth
        saveData()
        savedFavoritePeopleEntities = fetchUserFavorites()
    }
    
    func removeFavoritePeopleEntity(id: Int) {
        guard let entity = savedFavoritePeopleEntities.first(where: { $0.id == Int32(id) }) else { return }
        container.viewContext.delete(entity)
        saveData()
        savedUserRatingsEntites = fetchUserRatings()
    }
    
    //MARK: Others
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
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
    
    //MARK: Subscribers
    
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
    
    func addRatedItemSubscriber() {
        $savedUserRatingsEntites
            .map { (entities) -> [RatedItemModel] in
                var items: [RatedItemModel] = []
                for ent in entities {
                    let newItem = RatedItemModel(
                        id: Int(ent.id),
                        title: ent.title ?? "",
                        posterPath: ent.posterPath ?? "",
                        userRate: Int(ent.userRating)
                    )
                    items.append(newItem)
                }
                return items
            }
            .sink { value in
                self.savedUserRatingsItems = value
            }
            .store(in: &cancellables)
    }
    
    func addFavoriteItemsSubscriber() {
        $savedFavoritePeopleEntities
            .map { (entities) -> [FavoriteModel] in
                var items: [FavoriteModel] = []
                for ent in entities {
                    let newItem = FavoriteModel(
                        id: Int(ent.id),
                        name: ent.name ?? "",
                        placeOfBirth: ent.placeOfBirth ?? "",
                        profilePath: ent.profilePath ?? ""
                    )
                    items.append(newItem)
                }
                return items
            }
            .sink { value in
                self.savedFavoritePeopleItems = value
            }
            .store(in: &cancellables)
    }
}