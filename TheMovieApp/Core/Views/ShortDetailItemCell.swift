//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 07/03/2022.
//
import SwiftUI

struct ShortDetailItemCell: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @StateObject var vm: ShortDetailItemCellViewModel
    @State private var showRatingView = false
    
    init(topCastArray: [CastMember], backdropPath: String?, credits: Credits, item: ItemDetails, reviews: Reviews, movieDataService: MovieDataService) {
        self._vm = StateObject(wrappedValue: ShortDetailItemCellViewModel(topCastArray: topCastArray, backdropPath: backdropPath, credits: credits, item: item, reviews: reviews, movieDataService: movieDataService))
    }
    var body: some View {
        ZStack {
            ScrollView() {
                ZStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Group {
                            BackdropCell(backdropPath: vm.backdropPath)
                            basicInforation
                            HStack(spacing: 15) {
                                poster
                                VStack(alignment: .leading) {
                                    GenresCell(genresNames: vm.item.makeGenresNamesArray())
                                    overview
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        addToWatchListButton
                        voteAverageAndRateButtonRow
                            .fullScreenCover(isPresented: $showRatingView) {
                                if coreDataManager.savedUserRatingsItems.firstIndex(where: { $0.id == vm.item.id }) != nil {
                                    RateView(
                                        movieDataService: vm.movieDataService,
                                        movie: vm.item,
                                        rating: (coreDataManager.savedUserRatingsItems.first(where: { $0.id == vm.item.id })?.userRate)!
                                    )
                                } else {
                                    RateView(movieDataService: vm.movieDataService, movie: vm.item, rating: 0)
                                }
                            }
                        Divider()
                        seeFullDetailsButton
                        Divider()
                        topCast
                        Divider()
                        topReviews
                    }
                    .frame(width: UIScreen.main.bounds.size.width * 0.9)
                    .background(.regularMaterial)
                    .background(
                        ZStack {
                            background
                        }
                    )
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.bottom)
    }
}


struct ShortDetailItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemCell(topCastArray: [dev.castMember], backdropPath: dev.backdropPath, credits: dev.credits, item: dev.itemDetails, reviews: dev.reviews, movieDataService: MovieDataService())
    }
}

extension ShortDetailItemCell {
    private var background: some View {
        VStack {
            if vm.item.posterPath != nil {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + vm.item.posterPath!)) { image in
                    image
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.width * 0.9)
                } placeholder: {
                    Rectangle().fill(UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white)
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                }
            }
        }
    }
    
    private var basicInforation: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(vm.item.title)
                .font(.largeTitle)
                .fontWeight(.light)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            if vm.item.title != vm.item.originalTitle {
                Text(vm.item.originalTitle + " (original title)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text(vm.item.releaseDate.prefix(4))
                    .font(.footnote)
                    .foregroundColor(.secondary)
                if let runtime = vm.item.runtime {
                    Text("\(runtime) min")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.leading, 10)
                }
            }
            .padding(.top, 5)
            
        }.padding(.horizontal)
    }
    
    private var overview: some View {
        VStack {
            if vm.item.overview != nil {
                Text(vm.item.overview!)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(5)
            } else {
                Text("This material does not have a description added yet")
                
            }
        }
    }
    
    private var poster: some View {
        VStack {
            if vm.item.posterPath != nil {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + vm.item.posterPath!)) { image in
                        image
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4 * 1.5)
                            .scaledToFill()
                            .cornerRadius(5)
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.secondary)
                            .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4 * 1.5)
                            .cornerRadius(5)
                        ProgressView()
                    }
                    
                }
            }
        }
    }
    
    private var addToWatchListButton: some View {
        Button {
            if coreDataManager.savedWatchlistItems.contains(where: { $0.id == vm.item.id }) {
                coreDataManager.removeWatchlistEntity(id: vm.item.id)
            } else {
                coreDataManager.addWatchlistEntity(id: vm.item.id, title: vm.item.title, posterPath: vm.item.posterPath ?? "", voteAverage: vm.item.voteAverage)
            }
        } label: {
            HStack(spacing: 5) {
                Image(systemName: coreDataManager.savedWatchlistItems.contains(where: { $0.id == vm.item.id }) ? "checkmark" : "plus")
                    .foregroundColor(.white)
                Text("WatchList")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.cornerRadius(5))
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }
    
    private var voteAverageAndRateButtonRow: some View {
        ZStack(alignment: .center) {
            HStack {
                VoteAverageView(voteAverage: vm.item.voteAverage, voteCount: nil)
                Spacer()
            }
            RateButton(item: vm.item, showRatingView: $showRatingView)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var seeFullDetailsButton: some View {
        NavigationLink(destination: {
            LongDetailView(movieDataService: vm.movieDataService, topCastArray: vm.topCastArray, backdropPath: vm.backdropPath, credits: vm.credits, itemDetails: vm.item, reviews: vm.reviews)
        }, label: {
            Text("See full details")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.vertical, 6)
                .frame(maxWidth: .infinity)
                .background(Color.yellow.cornerRadius(5))
                .padding(.horizontal)
                .padding(.vertical, 8)
        })
    }
      
    
    private var topCast: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Top Cast")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                Spacer()
                
                NavigationLink {
                    AllCastView(movieDataService: vm.movieDataService, cast: vm.credits.cast, crew: vm.credits.crew, title: vm.item.title, date: vm.item.releaseDate)
                } label: {
                    Text("See All")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .fontWeight(.light)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(vm.topCastArray) { castMember in
                        CastMemberCapsule(castMember: castMember)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var topReviews: some View {
        VStack {
            HStack(alignment: .center) {
                Text("From top reviewers")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                Spacer()
                NavigationLink {
                    ReviewsView(movie: vm.item, reviews: vm.reviews, movieDataService: vm.movieDataService)
                } label: {
                    Text("See All")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .fontWeight(.light)
                }
            }
            .padding(.horizontal)
            
            if vm.reviews.results.isEmpty {
                Text("This movie has no reviews yet")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .padding()
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(vm.reviews.results) { review in
                            ShortReviewCell(review: review)
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
            }
        }
    }
}
