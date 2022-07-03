//
//  VoteAverageView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 02/04/2022.
//

import SwiftUI

struct VoteAverageView: View {
    
    let voteAverage: Double
    let voteCount: Int?
    let starFont: Font
    let font1: Font
    let font2: Font
    
    init(voteAverage: Double, voteCount: Int?, starFont: Font, font1: Font, font2: Font) {
        self.voteAverage = voteAverage
        self.voteCount = voteCount ?? nil
        self.starFont = starFont
        self.font1 = font1
        self.font2 = font2
    }
    init(voteAverage: Double, voteCount: Int?) {
        self.voteAverage = voteAverage
        self.voteCount = voteCount ?? nil
        self.starFont = Font.subheadline
        self.font1 = Font.headline
        self.font2 = Font.subheadline
    }
    
    var body: some View {
        HStack {
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(starFont)
                    HStack(alignment: .bottom, spacing: 0) {
                        Text(voteAverage.asStringWith1DecimalPlace())
                            .font(font1)
                            .foregroundColor(.primary)
                        Text("/10")
                            .foregroundColor(.primary)
                            .font(font2)
                            .fontWeight(.thin)
                    }
                }
                if voteCount != nil {
                    Text("\(voteCount!)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            //Spacer()
        }
    }
}

struct VoteAverageView_Previews: PreviewProvider {
    static var previews: some View {
        VoteAverageView(voteAverage: 6.4, voteCount: 10, starFont: Font.subheadline, font1: Font.headline, font2: Font.subheadline)
    }
}
