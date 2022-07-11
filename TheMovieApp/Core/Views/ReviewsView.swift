//
//  ReviewsView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 03/07/2022.
//

import SwiftUI

struct ReviewsView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @StateObject var vm: ReviewsViewModel
    @State private var showRatingView = false
    
    init(movie: ItemDetails, reviews: Reviews, movieDataService: MovieDataService) {
        self._vm = StateObject(wrappedValue: ReviewsViewModel(movie: movie, reviews: reviews, movieDataService: movieDataService))
    }
    
    
    var body: some View {
        ScrollView() {
            movieTitleAndYearRow
            ratingsRow
                .fullScreenCover(isPresented: $showRatingView) {
                    if coreDataManager.savedUserRatingsItems.firstIndex(where: { $0.id == vm.movie.id }) != nil {
                        RateView(
                            movieDataService: vm.movieDataService,
                            movie: vm.movie,
                            rating: (coreDataManager.savedUserRatingsItems.first(where: { $0.id == vm.movie.id })?.userRate)!
                        )
                    } else {
                        RateView(movieDataService: vm.movieDataService, movie: vm.movie, rating: 0)
                    }
                }
            Divider()
            if !vm.chartValues.isEmpty {
                chart
            }
            reviewsCounter
            VStack(spacing: 10) {
                if vm.selectedRateNumber > 0 {
                    ForEach(vm.filteredReviews) { review in
                        LongReviewCell(review: review)
                        Divider()
                        
                    }
                } else {
                    ForEach(vm.reviews.results) { review in
                        LongReviewCell(review: review)
                        Divider()
                    }
                }
            }
            .padding(.top, 10)
            .background(Color.secondary.opacity(0.1))
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(Text("Reviews"))
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(movie: dev.itemDetails, reviews: dev.reviews, movieDataService: MovieDataService())
    }
}

extension ReviewsView {
    private var movieTitleAndYearRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(vm.title) (\(vm.year))")
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                Spacer()
            }
            .background(Color.secondary.opacity(0.2))
            .frame(maxWidth: .infinity)
        }
    }
    
    private var ratingsRow: some View {
        HStack(alignment: .top, spacing: 40) {
            VStack(alignment: .leading, spacing: 8) {
                Text("TMDb rating")
                    .foregroundColor(.primary)
                VoteAverageView(voteAverage: vm.rating, voteCount: nil, starFont: .title2, font1: .title, font2: .subheadline)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Your rating")
                RateButton(item: vm.movie, showRatingView: $showRatingView, font1: .title, font2: .subheadline, noRatingFont: .title3)

            }
            Spacer()
        }
        .padding(.horizontal, 8)
    }
    
    private var chart: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Filter by rating")
                .foregroundColor(.secondary)
                .font(.subheadline)
            HStack(alignment: .bottom, spacing: 5) {
                ForEach(0..<10, id: \.self) { index in
                    VStack(spacing: 4) {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: vm.reviews.results.isEmpty ? 1 :
                                    CGFloat(vm.chartValues[index]) / CGFloat(vm.reviews.results.count) * CGFloat(100))
                            .foregroundColor(vm.selectedRateNumber - 1 == index ? .yellow : .secondary)
                        Text("\(index + 1)")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .onTapGesture {
                        if vm.chartValues[index] > 0 {
                            if vm.selectedRateNumber == index + 1 {
                                vm.selectedRateNumber = 0
                            } else {
                                vm.selectedRateNumber = index + 1
                            }
                        }
                    }
                }
            }
            //.frame(height: 110)
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 8)
    }
    
    private var reviewsCounter: some View {
        ZStack {
            if vm.selectedRateNumber == 0 {
                Text("\(vm.reviews.totalResults) reviews")
                        .foregroundColor(.primary)
                        .font(.subheadline)
            } else {
                Text("\(vm.filteredReviews.count) reviews")
                        .foregroundColor(.primary)
                        .font(.subheadline)
            }
        }
    }
}
