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
        VStack {

        }
    }
}

struct UserItemsView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemsView(coreDataManager: CoreDataManager(), movieDataService: MovieDataService())
    }
}
