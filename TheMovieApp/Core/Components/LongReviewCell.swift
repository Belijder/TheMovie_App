//
//  LongReviewCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 03/07/2022.
//

import SwiftUI

struct LongReviewCell: View {
    
    @State private var showAllContent = false
    
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 10) {
                    if review.authorDetails.rating != nil {
                    VoteAverageView(voteAverage: Double(review.authorDetails.rating!), voteCount: nil, starFont: .headline, font1: .headline, font2: .subheadline)
                    }
                    Text(review.authorDetails.name)
                        .bold()
                        .foregroundColor(.primary)
                }
                HStack(spacing: 10) {
                    Text(review.authorDetails.username)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Text(review.createdAt.asDateLikeStyle())
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                }
            }
            Text(review.content)
        }
        .onTapGesture {
            withAnimation(.easeInOut) { showAllContent.toggle() }
        }
        .padding(.horizontal, 8)
        .lineLimit(showAllContent ? nil : 5)
    }
}

struct LongReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        LongReviewCell(review: dev.reviews.results[0])
    }
}
