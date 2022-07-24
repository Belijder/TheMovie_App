//
//  SearchMovieView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 27/06/2022.
//

import SwiftUI

struct SearchMovieView: View {
    
    @StateObject var vm: SearchMovieViewModel
    @FocusState private var searchFieldIsFocused: Bool
    
    init(movieDataService: MovieDataService) {
        self._vm = StateObject(wrappedValue: SearchMovieViewModel(movieDataService: movieDataService))
    }
    
    var body: some View {
        NavigationView {
            VStack{
                TextField(" Search Movie", text: $vm.query)
                    .focused($searchFieldIsFocused)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .background(Color.primary.opacity(0.15))
                    .onChange(of: vm.query) { newValue in
                        Task {
                            await vm.getResultsOfSearchForQuery(query: newValue)
                        }
                    }
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.searchedMovies) { movie in
                            VStack(spacing:0) {
                                SearchMovieCell(movieDataService: vm.movieDataService, movie: movie)
                                    .padding(.bottom, 5)
                                Divider()
                                    .padding(.bottom, 5)
                            }
                        }
                    }
                    .padding(.horizontal, 8)

                }
                .onTapGesture {
                    searchFieldIsFocused = false
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
        
        
    }
}

struct SearchMovieView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMovieView(movieDataService: MovieDataService())
    }
}
