//
//  ContentView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/02/2022.
//

import SwiftUI

struct MainView: View {
    
    init(movieDataSerice: MovieDataService) {
        _mainViewVM = StateObject(wrappedValue: MainViewViewModel(movieDataService: movieDataSerice))
        _movieDataService = ObservedObject(wrappedValue: movieDataSerice)
    }
    
    @StateObject var mainViewVM: MainViewViewModel
    @ObservedObject var movieDataService: MovieDataService
    
    @State var url = URL(string: "")
    @State var selectedItem = 1
    @State var showShortDetailItemView = false
    
    var body: some View {
        ScrollView {
            WatchlistViewSegment(movieDataService: movieDataService)
                .padding(.bottom, 10)
            VStack(spacing: 10) {
                HeadLineRow(context: "Popular Movies")
                    .padding(.leading, 8)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(0..<mainViewVM.popularMovies.count, id: \.self) { index in
                                PortraitStyleMovieCell(movie: mainViewVM.popularMovies[index], movieDataService: movieDataService)
                                    .onTapGesture {
                                        selectedItem = index
                                        showShortDetailItemView = true
                                    }
                            }
                            .fullScreenCover(isPresented: $showShortDetailItemView) {
                                ShortDetailItemView(title: "Popular Movies", items: mainViewVM.popularMovies, currentItem: selectedItem, movieDataService: movieDataService)
                            }
                        }
                        .padding(.leading, 8)
                    }
            }
            .padding(.init(top: 5, leading: 0, bottom: 15, trailing: 0))
            .background(alignment: .center) {
                Color.secondary.opacity(0.1)
            }
        }
        .task {
            await mainViewVM.getPopularMovies()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(movieDataSerice: MovieDataService())
    }
}
