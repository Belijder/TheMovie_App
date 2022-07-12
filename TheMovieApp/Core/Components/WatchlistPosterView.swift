//
//  WatchlistPosterView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 10/07/2022.
//

import SwiftUI

struct WatchlistPosterView: View {
    
    init(movie: WatchlistModel, movieDataService: MovieDataService) {
        self._vm = StateObject(wrappedValue: WatchlistPosterViewModel(movie: movie, movieDataService: movieDataService))
    }
    
    @StateObject var vm: WatchlistPosterViewModel
    var body: some View {
            ZStack {
                if vm.itemDetails != nil && vm.reviews != nil && vm.credits != nil && !vm.topcastArray.isEmpty {
                    NavigationLink {
                        LongDetailView(movieDataService: vm.movieDataService, topCastArray: vm.topcastArray, backdropPath: vm.backdropPath, credits: vm.credits!, itemDetails: vm.itemDetails!, reviews: vm.reviews!)
                    } label: {
                        VStack(spacing: 0) {
                            AsyncImage(url: vm.url) { image in
                                    image
                                        .resizable()
                                        .frame(width: 180, height: 270)
                                        .scaledToFill()
                            } placeholder: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.secondary)
                                        .frame(width: 180, height: 270)
                                    ProgressView()
                                }
                                
                            }
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack(alignment: .center, spacing: 5) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.caption)
                                        Text("\(String(format: "%.1f", vm.movie.voteAverage))")
                                            .foregroundColor(.primary)
                                            .font(.footnote)
                                    }
                                    Text(vm.movie.title)
                                        .foregroundColor(.primary)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .lineLimit(1)
                                        
                                }
                                .padding(.leading, 8)
                                .padding(.vertical, 8)
                                Spacer()
                            }
                            .frame(width: 180)
                            .background(alignment: .center) {
                                Rectangle()
                                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                                    .foregroundColor(UITraitCollection.current.userInterfaceStyle == .dark ? Color.black : Color.white)
                            }
                        }
                    }
                } else {
                    VStack(spacing: 0) {
                        AsyncImage(url: vm.url) { image in
                                image
                                    .resizable()
                                    .frame(width: 180, height: 270)
                                    .scaledToFill()
                        } placeholder: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.secondary)
                                    .frame(width: 180, height: 270)
                                ProgressView()
                            }
                            
                        }
                        HStack(alignment: .center) {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                    Text("\(String(format: "%.1f", vm.movie.voteAverage))")
                                        .foregroundColor(.primary)
                                        .font(.footnote)
                                }
                                Text(vm.movie.title)
                                    .foregroundColor(.primary)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                    
                            }
                            .padding(.leading, 8)
                            .padding(.vertical, 8)
                            Spacer()
                        }
                        .frame(width: 180)
                        .background(alignment: .center) {
                            Rectangle()
                                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                                .foregroundColor(UITraitCollection.current.userInterfaceStyle == .dark ? Color.black : Color.white)
                        }
                    }
                }
                WatchlistCornerButton(item: vm.movie)
                
            }
            .task {
                vm.url = await vm.movieDataService.makePosterImageURL(movieId: vm.id)
            }
        }
}

struct WatchlistPosterView_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistPosterView(movie: dev.watchlistModel, movieDataService: MovieDataService())
    }
}

extension WatchlistPosterView {
    private var labelView: some View {
        VStack(spacing: 0) {
            AsyncImage(url: vm.url) { image in
                    image
                        .resizable()
                        .frame(width: 180, height: 270)
                        .scaledToFill()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.secondary)
                        .frame(width: 180, height: 270)
                    ProgressView()
                }
                
            }
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        Text("\(String(format: "%.1f", vm.movie.voteAverage))")
                            .foregroundColor(.primary)
                            .font(.footnote)
                    }
                    Text(vm.movie.title)
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        
                }
                .padding(.leading, 8)
                .padding(.vertical, 8)
                Spacer()
            }
            .frame(width: 180)
            .background(alignment: .center) {
                Rectangle()
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    .foregroundColor(UITraitCollection.current.userInterfaceStyle == .dark ? Color.black : Color.white)
            }
        }
    }
}
