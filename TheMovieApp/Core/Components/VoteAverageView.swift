//
//  VoteAverageView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/04/2022.
//

import SwiftUI

struct VoteAverageView: View {
    
    let voteAverage: Double
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.subheadline)
            HStack(alignment: .bottom, spacing: 0) {
                Text(voteAverage.asStringWith1DecimalPlace())
                    .font(.headline)
                Text("/10")
                    .foregroundColor(.primary)
                    .font(.subheadline)
                    .fontWeight(.thin)
            }
            Spacer()
        }
    }
}

struct VoteAverageView_Previews: PreviewProvider {
    static var previews: some View {
        VoteAverageView(voteAverage: 6.4)
    }
}
