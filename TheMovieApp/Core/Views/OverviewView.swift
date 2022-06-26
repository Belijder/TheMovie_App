//
//  OverviewView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/06/2022.
//

import SwiftUI

struct OverviewView: View {
    let title: String
    let overview: String
    let year: String
    
    var body: some View {
        ScrollView {
            Text(overview)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Plot: \(title) (\(year)")
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView(title: dev.itemDetails.title, overview: dev.itemDetails.overview ?? "", year: dev.itemDetails.releaseDate)
    }
}
