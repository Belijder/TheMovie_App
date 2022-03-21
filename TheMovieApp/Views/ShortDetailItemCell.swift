//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 07/03/2022.
//
import SwiftUI

struct ShortDetailItemCell: View {

    @EnvironmentObject var watchlistItems: WatchlistItems
    
    let backdropPath: String?

    let item: ItemDetails
    
    @State private var showVideoView = false

    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 10) {
                
                BackdropCell(backdropPath: backdropPath, showVideoView: $showVideoView, isVideoAnable: item.video)
                
                VStack(alignment: .leading, spacing: 5) {
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
                    
                }.padding(.horizontal)
                
                HStack(spacing: 15) {
                    //Poster
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
                    
                    //Genre and overview
                    VStack(alignment: .leading) {
                        GenresCell(genresNames: item.makeGenresNamesArray())
                        if item.overview != nil {
                            Text(item.overview!)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(5)
                        } else {
                            Text("This material does not have a description added yet")
                            
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                // Add to Watchlist Button
                Button {
                    if watchlistItems.checkIfItemIsInArray(id: item.id) {
                        watchlistItems.removeFromWatchlist(item: item)
                    } else {
                        watchlistItems.addToWatchlist(item: item)
                    }
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: watchlistItems.checkIfItemIsInArray(id: item.id) ? "checkmark" : "plus")
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
                
                //Rate Button and VoteAverange
                ZStack(alignment: .center) {
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("\(String(format: "%.1f", item.voteAverage))")
                                .font(.headline)
                            Text("/10")
                                .foregroundColor(.primary)
                                .font(.subheadline)
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    
                    VStack() {
                        Button {
                            //RateItemView
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: "star")
                                Text("Rate")
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                Divider()
                
                Button {
                    //Show full detail view
                } label: {
                    Text("See full details")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow.cornerRadius(5))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                Divider()
                
                topCast
                
                
            }
            .frame(width: UIScreen.main.bounds.size.width * 0.9)
            .background(Rectangle().fill(UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white)
                            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .fullScreenCover(isPresented: $showVideoView) {
            VideoView()
        }
    }
}


struct ShortDetailItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemCell(backdropPath: "", item: ItemDetails.example)
    }
}


extension ShortDetailItemCell {
    
    private var topCast: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Top Cast")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                Spacer()
                Button {
                    //Show all cast
                } label: {
                    Text("See All")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .fontWeight(.light)
                }
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        
                    }
                }

            }
        }
        .padding(.horizontal)
        
    }
}
