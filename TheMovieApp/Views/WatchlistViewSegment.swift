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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WatchlistViewSegment_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistViewSegment()
    }
}
