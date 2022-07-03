//
//  ReviewsViewModel.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 03/07/2022.
//

import Foundation
import Combine

class ReviewsViewModel: ObservableObject {
    let title: String
    let year: String
    let rating: Double
    let reviews: Reviews
    let movie: ItemDetails
    @Published var chartValues: [Int] = []
    @Published var selectedRateNumber: Int = 0
    @Published var filteredReviews: [Review] = []
    var cancellables = Set<AnyCancellable>()
    
    
    init(movie: ItemDetails, reviews: Reviews) {
        self.title = movie.title
        self.year = movie.releaseDate.first4characters()
        self.rating = movie.voteAverage
        self.reviews = reviews
        self.movie = movie
        countChartValues()
        addSelectedRateNumberSubscriber()
    }
    
    func countChartValues() {
        var values = [Int]()
        for number in 1..<11 {
            let filteredReviews = reviews.results.filter { $0.authorDetails.rating == number }
            values.append(filteredReviews.count)
        }
        self.chartValues = values
        print(chartValues)
    }
    
    func addSelectedRateNumberSubscriber() {
        $selectedRateNumber
            .map { (number) -> [Review] in
                return self.reviews.results.filter { $0.authorDetails.rating == number }
            }
            .sink { [weak self] value in
                self?.filteredReviews = value
            }
            .store(in: &cancellables)
    }
    
}
