//
//  TopRatedMovieSegment.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 17/07/2022.
//

import SwiftUI

struct TopRatedMoviesSegment: View {
    
    @StateObject var vm: TopRatedMoviesSegmentVM
    
    
    var body: some View {
        VStack(spacing: 10) {
            HeadLineRow(context: "Top Rated Movies")
                .padding(.leading, 8)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<vm.topRatedMoviesDetails.count, id: \.self) { index in
                            NavigationLink {
                                ShortDetailItemView(title: "Top Rated Movies", items: vm.topRatedMoviesDetails, currentItem: index, movieDataService: vm.movieDataService)
                            } label: {
                                PortraitStyleMovieCell(movie: vm.topRatedMoviesDetails[index], movieDataService: vm.movieDataService)
                            }
                        }
                    }
                    .padding(.leading, 8)
                }
        }
        .padding(.init(top: 5, leading: 0, bottom: 15, trailing: 0))
        .background(alignment: .center) {
            Color.secondary.opacity(0.1)
        }
        .task {
            await vm.getTopRatedMoviesDetails()
        }
    }
    
    init(movieDataService: MovieDataService) {
        self._vm = StateObject(wrappedValue: TopRatedMoviesSegmentVM(movieDataService: movieDataService))
    }
}

struct TopRatedMovieSegment_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedMoviesSegment(movieDataService: MovieDataService())
    }
}
