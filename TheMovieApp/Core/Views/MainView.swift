//
//  ContentView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/02/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainViewVM: MainViewViewModel
    @ObservedObject var movieDataService: MovieDataService
    @ObservedObject var coreDataManager: CoreDataManager
    
    @State var url = URL(string: "")
    @State var selectedItem = 1
    @State var showShortDetailItemView = false
    
    var body: some View {
        NavigationView {
        VStack(spacing: 0) {
            Divider()
                .foregroundColor(.clear)
            ScrollView {
                LazyVStack(spacing: 10) {
                    WatchlistViewSegment(movieDataService: movieDataService)
                        .padding(.bottom, 10)
                    VStack(spacing: 10) {
                        HeadLineRow(context: "Popular Movies")
                            .padding(.leading, 8)
                        if mainViewVM.popularMovies.isEmpty {
                            VStack {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 240)
                            }
                        } else {
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(0..<mainViewVM.popularMovies.count, id: \.self) { index in
                                        NavigationLink  {
                                            ShortDetailItemView(title: "Popular Movies", items: mainViewVM.popularMovies, currentItem: index, movieDataService: movieDataService)
                                        } label: {
                                            PortraitStyleMovieCell(movie: mainViewVM.popularMovies[index], movieDataService: movieDataService)
                                        }
                                    }
                                }
                                .padding(.leading, 8)
                            }
                        }
                    }
                    .padding(.init(top: 5, leading: 0, bottom: 15, trailing: 0))
                    .background(alignment: .center) {
                        Color.secondary.opacity(0.1)
                    }
                    TopRatedMoviesSegment(movieDataService: movieDataService)
                    if coreDataManager.savedUserRatingsItems.contains(where: { $0.userRate > 7 }) {
                        RecommendationsSegment(movieDataService: movieDataService, coreDataManager: coreDataManager)
                    }
                }
            }
        }
        .task {
            await mainViewVM.getPopularMovies()
        }
        .navigationBarTitle("Home")
        .navigationBarHidden(true)
        }
    }
    
    init(movieDataSerice: MovieDataService, coreDataManager: CoreDataManager) {
        _mainViewVM = StateObject(wrappedValue: MainViewViewModel(movieDataService: movieDataSerice))
        _movieDataService = ObservedObject(wrappedValue: movieDataSerice)
        _coreDataManager = ObservedObject(wrappedValue: coreDataManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(movieDataSerice: MovieDataService(), coreDataManager: CoreDataManager())
    }
}
