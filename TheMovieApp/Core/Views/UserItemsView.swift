//
//  UserItemsView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 13/07/2022.
//

import SwiftUI

struct UserItemsView: View {
    init(coreDataManager: CoreDataManager, movieDataService: MovieDataService) {
        self._vm = StateObject(wrappedValue: UserItemsViewModel(coreDataManager: coreDataManager, movieDataService: movieDataService))
    }

    @StateObject var vm: UserItemsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView() {
                    VStack(spacing: 10) {
                        NavigationLink {
                            RatingsView(movieDataService: vm.movieDataService)
                        } label: {
                            RatingsBanner(movieDataService: vm.movieDataService)
                        }
                        WatchlistViewSegment(movieDataService: vm.movieDataService)
                        FavoritePersonsSegment(movieDataService: vm.movieDataService, persons: vm.favoritePersons)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct UserItemsView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemsView(coreDataManager: CoreDataManager(), movieDataService: MovieDataService())
    }
}
