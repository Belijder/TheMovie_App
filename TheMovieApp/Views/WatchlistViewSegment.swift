//
//  WatchlistViewSegment.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 03/03/2022.
//

import SwiftUI

struct WatchlistViewSegment: View {
    
    @EnvironmentObject var watchlistItems: WatchlistItems
    
    var body: some View {
        VStack(spacing: 10) {
            HeadLineRow(context: "WatchList")
                .padding(.leading, 8)
            if watchlistItems.items.isEmpty {
                
            } else {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(watchlistItems.items) { movie in
                            
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
    }
}

struct WatchlistViewSegment_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistViewSegment()
    }
}
