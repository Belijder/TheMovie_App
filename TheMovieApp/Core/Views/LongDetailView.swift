//
//  LongDetailView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/04/2022.
//

import SwiftUI

struct LongDetailView: View {
    
    @StateObject var vm: LongDetailViewModel
    @EnvironmentObject var watchlistItems: WatchlistItems
    @EnvironmentObject var ratedMovies: RatedMovies
    
    init(movieDataService: MovieDataService, topCastArray: [CastMember], backdropPath: String?, credits: Credits, itemDetails: ItemDetails, reviews: Reviews) {
        self._vm = StateObject(wrappedValue: LongDetailViewModel(movieDataService: movieDataService, topCastArray: topCastArray, backdropPath: backdropPath, credits: credits, itemDetails: itemDetails, reviews: reviews))
    }
    
//   init(movieDataService: MovieDataService, movie: SearchedMovie) {
//
//        var reviews = Reviews.example
//
//        Task {
//            async let fetchReviews = movieDataService.fetchReviews(movieID: movie.id)
//            async let fetchTopCast = movieDataService.makeTopCast(for: movie.id)
//            async let fetchCredits = movieDataService.fetchCreditsfor(movieID: movie.id)
//            async let fetchItemDetails = movieDataService.fetchMovieDetails(id: movie.id)
//
//            reviews = await fetchReviews
//
//        }
        
//        var complexData = ComplexDataForLongDetailView(topCastArray: [], backdropPath: [], credits: [], itemDetails: ItemDetails.example, reviews: Reviews.example, character: "")
        
//        var complexData: ComplexDataForLongDetailView {
//            Task {
//            async let fetchReviews = movieDataService.fetchReviews(movieID: movie.id)
//            async let fetchTopCast = movieDataService.makeTopCast(for: movie.id)
//            async let fetchCredits = movieDataService.fetchCreditsfor(movieID: movie.id)
//            async let fetchItemDetails = movieDataService.fetchMovieDetails(id: movie.id)
//
//            let (reviews, cast, credits, details) = await (fetchReviews, fetchTopCast, fetchCredits, fetchItemDetails)
//                let backdropPath = await fetchItemDetails?.backdropPath
//
//            return ComplexDataForLongDetailView(topCastArray: cast, backdropPath: backdropPath, credits: credits, itemDetails: details, reviews: reviews, character: "")
//            }
//        }
//
//        self._vm = StateObject(wrappedValue: LongDetailViewModel(movieDataService: movieDataService, topCastArray: complexData.topCastArray, backdropPath: complexData.backdropPath, credits: complexData.credits, itemDetails: complexData.itemDetails, reviews: complexData.reviews))
        
//        Task {
//        async let fetchReviews = movieDataService.fetchReviews(movieID: movie.id)
//        async let fetchTopCast = movieDataService.makeTopCast(for: movie.id)
//        async let fetchCredits = movieDataService.fetchCreditsfor(movieID: movie.id)
//        async let fetchItemDetails = movieDataService.fetchMovieDetails(id: movie.id)
//
//        let (reviews, cast, credits, details) = await (fetchReviews, fetchTopCast, fetchCredits, fetchItemDetails)
//            let backdropPath = await fetchItemDetails?.backdropPath
//            complexData.itemDetails = await fetchItemDetails
//            complexData.credits = await fetchCredits
//            complexData.reviews = await fetchReviews
//            complexData.topCastArray = await fetchTopCast
            
//            self._vm = StateObject(wrappedValue: LongDetailViewModel(movieDataService: movieDataService, topCastArray: cast, backdropPath: backdropPath, credits: credits, itemDetails: details!, reviews: reviews))

        
//    }
    
    @State private var showVideoView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                titleYearRuntime
                backdrop
                HStack(spacing: 10) {
                    poster
                    VStack(alignment: .leading) {
                        GenresCell(genresNames: vm.itemDetails.makeGenresNamesArray())
                        overview
                    }
                }
                .padding(.horizontal, 10)
                addToWatchListButton
                Divider()
                voteAverageAndRateButtonRow
                    .fullScreenCover(isPresented: $vm.showRatingView) {
                        if ratedMovies.items.firstIndex(where: { $0.id == vm.itemDetails.id }) != nil {
                            RateView(
                                movieDataService: vm.movieDataService,
                                movie: vm.itemDetails,
                                rating: (ratedMovies.items.first(where: { $0.id == vm.itemDetails.id })?.userRating)!
                            )
                        } else {
                            RateView(movieDataService: vm.movieDataService, movie: vm.itemDetails, rating: 0)
                        }
                    }
            }
            .padding(.vertical, 8)
            .background(alignment: .center) {
                Color.secondary.opacity(0.1)
            }
            
            VStack(spacing: 10) {
                HStack {
                    HeadLineRow(context: "Cast")
                    Spacer()
                    NavigationLink {
                        AllCastView(movieDataService: vm.movieDataService, cast: vm.credits.cast, crew: vm.credits.crew, title: vm.itemDetails.title, date: vm.itemDetails.releaseDate)
                    } label: {
                        Text("See All")
                    }
                }
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .top, spacing: 5) {
                        ForEach(vm.credits.cast) { castMember in
                            if let index = vm.findIndexForPersonDetails(id: castMember.id) {
                                NavigationLink {
                                    CastMemberDetailView(person: vm.personsDetails[index], movieDataService: vm.movieDataService)
                                } label: {
                                    CastCellVertical(movieDataService: vm.movieDataService, castMember: castMember)
                                }
                            }
                            
                        }
                    }
                }
                .task {
                   await vm.getPersonDetailsForCastMembers()
                }
            }
            .padding(.horizontal, 10)
            
            
        }
        .navigationTitle(vm.itemDetails.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LongDetailView(movieDataService: MovieDataService(), topCastArray: [dev.castMember, dev.castMember, dev.castMember], backdropPath: dev.backdropPath, credits: dev.credits, itemDetails: dev.itemDetails, reviews: dev.reviews)
    }
}

extension LongDetailView {
    private var titleYearRuntime: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(vm.itemDetails.title)
                .font(.title)
                .foregroundColor(.primary)
            HStack(spacing: 20) {
                Text(vm.itemDetails.releaseDate.prefix(4))
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                if vm.itemDetails.runtime != nil {
                    if vm.itemDetails.runtime! > 0 {
                        Text("\(vm.itemDetails.runtime!) min")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
    }
    private var backdrop: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                if vm.backdropPath != nil {
                    AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + vm.backdropPath!)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.secondary)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.77777777777778)
                            ProgressView()
                        }
                        
                    }
                } else {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.secondary)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.77777777777778)
                        Image(systemName: "photo.fill")
                            .font(.largeTitle)
                    }
                }
                LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .bottom, endPoint: .top)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.77777777777778)
            }
        }
    }
    private var overview: some View {
        VStack {
            if vm.itemDetails.overview != nil {
                NavigationLink {
                    OverviewView(title: vm.itemDetails.title, overview: vm.itemDetails.overview!, year: String(vm.itemDetails.releaseDate.prefix(4)))
                } label: {
                    HStack(spacing: 10) {
                        Text(vm.itemDetails.overview!)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(5)
                            .multilineTextAlignment(.leading)
                        Image(systemName: "chevron.forward")
                    
                    }
                }
            } else {
                Text("This material does not have a description added yet")
                
            }
        }
    }
    private var poster: some View {
        AsyncImage(url: vm.posterURL) { image in
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
    
    private var addToWatchListButton: some View {
        Button {
            if watchlistItems.checkIfItemIsInArray(id: vm.itemDetails.id) {
                watchlistItems.removeFromWatchlist(item: vm.itemDetails)
            } else {
                watchlistItems.addToWatchlist(item: vm.itemDetails)
            }
        } label: {
            HStack(spacing: 5) {
                Image(systemName: watchlistItems.checkIfItemIsInArray(id: vm.itemDetails.id) ? "checkmark" : "plus")
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
                VoteAverageView(voteAverage: vm.itemDetails.voteAverage, voteCount: vm.itemDetails.voteCount)
                Spacer()
            }
            RateButton(item: vm.itemDetails, showRatingView: $vm.showRatingView)
        }
        .padding(.horizontal, 10)
    }
}
