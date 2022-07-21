//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 09/03/2022.
//

import SwiftUI
import Introspect

struct ShortDetailItemView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var movieDataService: MovieDataService
    @StateObject var vm: ShortDetailItemViewViewModel
    
    let title: String
    let items: [ItemDetails]
    @State var currentItem: Int

    var body: some View {
        ZStack {
            Color.secondary.opacity(0.1)
            VStack {
                if vm.isProgresViewEnabled {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    TabView(selection: $currentItem) {
                        ForEach(0..<20) { index in
                            ShortDetailItemCell(topCastArray: vm.topCasts[index],
                                                backdropPath: items[index].backdropPath,
                                                credits: vm.credits[index],
                                                item: items[index],
                                                reviews: vm.reviews[index] ?? Reviews.example,
                                                movieDataService: vm.movieDataService
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }.task {
                await vm.fetchCastAndReviews()
            }
            .navigationBarTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    init(title: String, items: [ItemDetails], currentItem: Int, movieDataService: MovieDataService) {
        self.title = title
        self.items = items
        _currentItem = State(wrappedValue: currentItem)
        _vm = StateObject(wrappedValue: ShortDetailItemViewViewModel(items: items))
        _movieDataService = ObservedObject(wrappedValue: movieDataService)
        
    }
}

struct ShortDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemView(title: "Popular Movies", items: [], currentItem: 1, movieDataService: MovieDataService())
    }
}
