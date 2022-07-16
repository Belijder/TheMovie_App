//
//  HorizontalStyleMovieCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 16/07/2022.
//

import SwiftUI

struct HorizontalStyleMovieCell: View {
    
    @StateObject var vm: HorizontalStyleMovieCellViewModel
    
    var body: some View {
        ZStack {
            if vm.details != nil {
                NavigationLink {
                    Text(vm.title)
                } label: {
                    HStack(spacing: 10) {
                        ZStack {
                            poster
                                .overlay(
                                    WatchlistCornerButton(item: WatchlistModel(id: vm.id, title: vm.title, posterPath: vm.posterPath, voteAverage: vm.voteAverage))
                                )
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text(vm.title)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                            HStack(spacing: 10) {
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.footnote)
                                    Text("\(vm.voteAverage.asStringWith1DecimalPlace())")
                                        .foregroundColor(.primary)
                                        .font(.footnote)
                                }
                                if vm.userRating != nil {
                                    HStack(spacing: 4) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.blue)
                                            .font(.footnote)
                                        Text("\(vm.userRating!)")
                                            .foregroundColor(.primary)
                                            .font(.footnote)
                                    }
                                }
                                Text(vm.releaseDate.first4characters())
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                                if vm.runtime != nil && vm.runtime! > 0 {
                                    Text("\(vm.runtime!)")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                }
                            }
                            if vm.ratingDate != nil {
                                Text("Rated on \(vm.ratingDate!.asStringWithMediumForrmaterDataStyle())")
                                    .foregroundColor(.secondary)
                                    .font(.footnote)
                            }
                        }
                        
                    }
                }
            }
        }
        .task {
            await vm.getURL()
        }
        .task {
            await vm.getDetails()
        }
        
    }
    
    
    
    
    init(id: Int, title: String, releaseDate: String, voteAverage: Double, userRating: Int? = nil, ratingDate: Date? = nil, posterPath: String, runtime: Int?, movieDataService: MovieDataService) {
        self._vm = StateObject(wrappedValue: HorizontalStyleMovieCellViewModel(id: id, title: title, releaseDate: releaseDate, voteAverage: voteAverage, userRating: userRating, ratingDate: ratingDate, posterPath: posterPath, runtime: runtime, movieDataService: movieDataService))
    }
    
}

struct HorizontalStyleMovieCell_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalStyleMovieCell(id: dev.itemDetails.id, title: dev.itemDetails.title, releaseDate: dev.itemDetails.releaseDate, voteAverage: dev.itemDetails.voteAverage, userRating: 7, ratingDate: Date.now, posterPath: dev.posterPath, runtime: dev.itemDetails.runtime, movieDataService: MovieDataService())
    }
}

extension HorizontalStyleMovieCell {
    private var poster: some View {
        AsyncImage(url: vm.url) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 150)
                    .scaledToFill()
        } placeholder: {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.secondary)
                    .frame(width: 100, height: 150)
                Image(systemName: "photo")
            }
            
        }
    }
}
