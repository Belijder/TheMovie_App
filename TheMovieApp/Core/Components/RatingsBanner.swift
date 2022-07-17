//
//  RatingsBanner.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 14/07/2022.
//

import SwiftUI

struct RatingsBanner: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    
    
    var body: some View {
        HStack(spacing: 10) {
            
            posters
            VStack(alignment: .leading) {
                Text("Ratings")
                    .foregroundColor(.primary)
                Text("\(coreDataManager.savedUserRatingsItems.count)")
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.leading, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(Color.secondary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .background(Color.secondary.opacity(0.1))
    }
}

struct RatingsBanner_Previews: PreviewProvider {
    static var previews: some View {
        RatingsBanner(movieDataService: MovieDataService())
    }
}

extension RatingsBanner {
    private var posters: some View {
        ZStack {
            HStack {
                Spacer()
                ZStack {
                    if coreDataManager.savedUserRatingsItems.count > 2 {
                        PosterInRatedBanner(movieDataService: movieDataService,
                               movieID: coreDataManager.savedUserRatingsItems[coreDataManager.savedUserRatingsItems.count - 3].id
                        )
                    } else {
                        placeholder
                    }
                    Color.black.opacity(0.4)
                        .frame(width: 60, height: 90)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
            }
            ZStack {
                posterShadow
                if coreDataManager.savedUserRatingsItems.count > 1 {
                    PosterInRatedBanner(movieDataService: movieDataService,
                           movieID: coreDataManager.savedUserRatingsItems[coreDataManager.savedUserRatingsItems.count - 2].id
                    )
                } else {
                    placeholder
                }
                Color.black.opacity(0.2)
                    .frame(width: 60, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            
            HStack {
                ZStack{
                    posterShadow
                    if coreDataManager.savedUserRatingsItems.count > 0 {
                        PosterInRatedBanner(movieDataService: movieDataService,
                               movieID: coreDataManager.savedUserRatingsItems[coreDataManager.savedUserRatingsItems.count - 1].id
                        )
                    } else {
                        placeholder
                    }
                }
                Spacer()
            }
        }
        .frame(width: 110)
    }
    
    private var placeholder: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary)
                .frame(width: 60, height: 90)
            Image(systemName: "photo.fill")
                .foregroundColor(.primary)
        }
    }
    
    private var posterShadow: some View {
        Color.black
            .frame(width: 60, height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(x: 1, y: 0)
    }
}



