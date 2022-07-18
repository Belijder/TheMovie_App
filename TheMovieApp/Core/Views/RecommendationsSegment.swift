//
//  RecommendationsSegment.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 17/07/2022.
//

import SwiftUI

struct RecommendationsSegment: View {
    
    @StateObject var vm: RecommendationsSegmentVM
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                HeadLineRow(context: "You might also like")
                    .padding(.leading, 8)
                if vm.recommendationItem != nil {
                    Text("Because you watched \(vm.recommendationItem!.title)")
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
                                ShortDetailItemView(title: "You might also like", items: vm.recommendations, currentItem: index, movieDataService: vm.movieDataService)
                            } label: {
                                PortraitStyleMovieCell(movie: vm.recommendations[index], movieDataService: vm.movieDataService)
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
        .task {
            vm.getMovieIdForRecommendations()
            await vm.getRecommendations()
        }
    }
    
    init(movieDataService: MovieDataService, coreDataManager: CoreDataManager) {
        self._vm = StateObject(wrappedValue: RecommendationsSegmentVM(movieDataService: movieDataService, coreDataManager: coreDataManager))
    }
}

struct RecommendationsSegment_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationsSegment(movieDataService: MovieDataService(), coreDataManager: CoreDataManager())
    }
}
