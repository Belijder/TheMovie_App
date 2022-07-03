//
//  RateButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 03/07/2022.
//

import SwiftUI

struct RateButton: View {
    
    @EnvironmentObject var ratedMovies: RatedMovies
    let item: ItemDetails
    @Binding var showRatingView: Bool
    
    var body: some View {
        VStack() {
            Button {
                showRatingView = true
            } label: {
                if ratedMovies.items.contains(where: { $0.id == item.id }) {
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.blue)
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("\((ratedMovies.items.first(where: { $0.id == item.id })?.userRating)!)")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.primary)
                            Text("/10")
                                .font(.subheadline)
                                .fontWeight(.thin)
                                .foregroundColor(.primary)
                        }
                    }
                } else {
                    HStack(spacing: 5) {
                        Image(systemName: "star")
                        Text("Rate")
                    }
                    .foregroundColor(.blue)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct RateButton_Previews: PreviewProvider {
    static var previews: some View {
        RateButton(item: dev.itemDetails, showRatingView: .constant(true))
    }
}
