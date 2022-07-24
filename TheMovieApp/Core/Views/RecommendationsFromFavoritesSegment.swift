//
//  RecommendationsFromFavoritesSegment.swift
//  TheMovieApp
//
//  Created by Jakub Zajda on 24/07/2022.
//

import SwiftUI

struct RecommendationsFromFavoritesSegment: View {
    @StateObject var vm: RecommendationsFromFavoritesSegmentVM
    
    var body: some View {
            VStack(spacing: 10) {
                if vm.recommendationItem != nil {
                    VStack(alignment: .leading, spacing: 0) {
                        HeadLineRow(context: "More from \(vm.recommendationItem!.name)")
                            .padding(.leading, 8)
                        if vm.recommendationItem != nil {
                            Text("Because they're one of your favorite people")
                                .foregroundColor(.secondary)
                                .font(.footnote)
                                .padding(.leading, 8)
                        }
                    }
                    if vm.recommendations.isEmpty {
                        VStack {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                                .frame(height: 240)
                        }
                    } else {
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(0..<vm.recommendations.count, id: \.self) { index in
                                    NavigationLink {
                                        ShortDetailItemView(title: "More from \(vm.recommendationItem!.name)", items: vm.recommendations, currentItem: index, movieDataService: vm.movieDataService)
                                    } label: {
                                        PortraitStyleMovieCell(movie: vm.recommendations[index], movieDataService: vm.movieDataService)
                                    }
                                }
                            }
                            .padding(.leading, 8)
                        }
                    }
                }
            }
            .padding(.init(top: 5, leading: 0, bottom: 15, trailing: 0))
            .background(alignment: .center) {
                Color.secondary.opacity(0.1)
            }
            .task {
                vm.getMovieIdForRecommendations()
                await vm.getRecommendations()
            }
    }
    
    init(movieDataService: MovieDataService, coreDataManager: CoreDataManager) {
        self._vm = StateObject(wrappedValue: RecommendationsFromFavoritesSegmentVM(movieDataService: movieDataService, coreDataManager: coreDataManager))
    }
}

struct RecommendationsFromFavoritesSegment_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsFromFavoritesSegment(movieDataService: MovieDataService(), coreDataManager: CoreDataManager())
    }
}
