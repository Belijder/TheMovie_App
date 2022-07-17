//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 07/03/2022.
//
import SwiftUI

struct ShortDetailItemCell: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    let topCastArray: [CastMember]
    let backdropPath: String?
    let credits: Credits
    let item: ItemDetails
    let reviews: Reviews
    @State private var showVideoView = false
    @State private var showfullDetailView = false
    @State private var showRatingView = false
    
    

    var body: some View {
        ZStack {
            ScrollView() {
                ZStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Group {
                            BackdropCell(backdropPath: backdropPath, showVideoView: $showVideoView, isVideoAnable: item.video)
                            basicInforation
                            HStack(spacing: 15) {
                                poster
                                VStack(alignment: .leading) {
                                    GenresCell(genresNames: item.makeGenresNamesArray())
                                    overview
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        addToWatchListButton
                        voteAverageAndRateButtonRow
                            .fullScreenCover(isPresented: $showRatingView) {
                                if coreDataManager.savedUserRatingsItems.firstIndex(where: { $0.id == item.id }) != nil {
                                    RateView(
                                        movieDataService: movieDataService,
                                        movie: item,
                                        rating: (coreDataManager.savedUserRatingsItems.first(where: { $0.id == item.id })?.userRate)!
                                    )
                                } else {
                                    RateView(movieDataService: movieDataService, movie: item, rating: 0)
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
        .fullScreenCover(isPresented: $showVideoView) {
            VideoView()
        }
    }
}


struct ShortDetailItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemCell(movieDataService: MovieDataService(), topCastArray: [], backdropPath: "", credits: Credits.example, item: ItemDetails.example, reviews: Reviews.example)
    }
}

extension ShortDetailItemCell {
    
    private var background: some View {
        VStack {
            if item.posterPath != nil {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + item.posterPath!)) { image in
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
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.light)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            if item.title != item.originalTitle {
                Text(item.originalTitle + " (original title)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            HStack {
                Text(item.releaseDate.prefix(4))
                    .font(.footnote)
                    .foregroundColor(.secondary)
                if let runtime = item.runtime {
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
            if item.overview != nil {
                Text(item.overview!)
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
            if item.posterPath != nil {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + item.posterPath!)) { image in
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
            if coreDataManager.savedWatchlistItems.contains(where: { $0.id == item.id }) {
                coreDataManager.removeWatchlistEntity(id: item.id)
            } else {
                coreDataManager.addWatchlistEntity(id: item.id, title: item.title, posterPath: item.posterPath ?? "", voteAverage: item.voteAverage)
            }
        } label: {
            HStack(spacing: 5) {
                Image(systemName: coreDataManager.savedWatchlistItems.contains(where: { $0.id == item.id }) ? "checkmark" : "plus")
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
                VoteAverageView(voteAverage: item.voteAverage, voteCount: nil)
                Spacer()
            }
            RateButton(item: item, showRatingView: $showRatingView)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var seeFullDetailsButton: some View {
        NavigationLink(destination: {
            LongDetailView(movieDataService: movieDataService, topCastArray: topCastArray, backdropPath: backdropPath, credits: credits, itemDetails: item, reviews: reviews)
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
                    AllCastView(movieDataService: movieDataService, cast: credits.cast, crew: credits.crew, title: item.title, date: item.releaseDate)
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
                    ForEach(topCastArray) { castMember in
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
                    ReviewsView(movie: item, reviews: reviews, movieDataService: movieDataService)
                } label: {
                    Text("See All")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .fontWeight(.light)
                }
            }
            .padding(.horizontal)
            
            if reviews.results.isEmpty {
                Text("This movie has no reviews yet")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                    .padding()
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(reviews.results) { review in
                            ShortReviewCell(review: review)
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
            }
        }
    }
}
