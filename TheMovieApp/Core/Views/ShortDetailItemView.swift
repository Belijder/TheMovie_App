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
    @StateObject var shortDetailItemViewViewModel: ShortDetailItemViewViewModel
    
    let title: String
    let items: [ItemDetails]
    @State var currentItem: Int
    @State var scrolltoItem = 0

    var body: some View {
        ZStack {
            Color.secondary.opacity(0.1)
            VStack {
                if shortDetailItemViewViewModel.isProgresViewEnabled {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    TabView(selection: $currentItem) {
                        ForEach(0..<20) { index in
                            ShortDetailItemCell(movieDataService: movieDataService, topCastArray: shortDetailItemViewViewModel.topCasts[index], backdropPath: items[index].backdropPath, credits: shortDetailItemViewViewModel.credits[index], item: items[index], reviews: shortDetailItemViewViewModel.reviews[items[index].id] ?? Reviews.example
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                }
            }.task {
                await shortDetailItemViewViewModel.fetchCastAndReviews()
            }
            .navigationBarTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    init(title: String, items: [ItemDetails], currentItem: Int, movieDataService: MovieDataService) {
        self.title = title
        self.items = items
        _currentItem = State(wrappedValue: currentItem)
        _shortDetailItemViewViewModel = StateObject(wrappedValue: ShortDetailItemViewViewModel(items: items))
        _movieDataService = ObservedObject(wrappedValue: movieDataService)
        
    }
}

struct ShortDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemView(title: "Popular Movies", items: [], currentItem: 1, movieDataService: MovieDataService())
    }
}
