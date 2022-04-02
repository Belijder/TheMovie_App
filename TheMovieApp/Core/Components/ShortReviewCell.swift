//
//  ShortReviewCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/04/2022.
//

import SwiftUI

struct ShortReviewCell: View {
    
    let review: Review
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(UITraitCollection.current.userInterfaceStyle == .dark ? .secondary.opacity(0.2) : .white)
                .shadow(color: .secondary.opacity(0.2), radius: 3, x: 0, y: 0)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if review.authorDetails.rating != nil {
                        HStack(spacing: 5) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(review.authorDetails.rating!)")
                        }
                        .font(.subheadline)
                    }
                    Text(review.author)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text(review.content)
                        .font(.footnote)
                    Spacer()
                    
                }
                .padding([.top, .leading, .trailing])
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.7 / 1.7)
            
            
    }
}

struct ShortReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ShortReviewCell(review: Review(author: "Kuba Rozprówacz", authorDetails: AuthorDetails(name: "", username: "", avatarPath: "", rating: 10), content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ", createdAt: "", id: "", updatedAt: "", url: ""))
            .previewLayout(.sizeThatFits)
        
        ShortReviewCell(review: Review(author: "Kuba Rozprówacz", authorDetails: AuthorDetails(name: "", username: "", avatarPath: "", rating: 10), content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ", createdAt: "", id: "", updatedAt: "", url: ""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)

    }
}
