//
//  RateButton.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 03/07/2022.
//

import SwiftUI

struct RateButton: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    let item: ItemDetails
    @Binding var showRatingView: Bool
    let font1: Font
    let font2: Font
    let noRatingFont: Font
    
    init(item: ItemDetails, showRatingView: Binding<Bool>) {
        self.item = item
        self._showRatingView = showRatingView
        self.font1 = Font.headline
        self.font2 = Font.subheadline
        self.noRatingFont = font2
    }
    
    init(item: ItemDetails, showRatingView: Binding<Bool>, font1: Font, font2: Font, noRatingFont: Font) {
        self.item = item
        self._showRatingView = showRatingView
        self.font1 = font1
        self.font2 = font2
        self.noRatingFont = noRatingFont
    }
    
    var body: some View {
        VStack() {
            Button {
                showRatingView = true
            } label: {
                if coreDataManager.savedUserRatingsItems.contains(where: { $0.id == item.id }) {
                    HStack(spacing: 5) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.blue)
                        HStack(alignment: .bottom, spacing: 0) {
                            Text("\((coreDataManager.savedUserRatingsItems.first(where: { $0.id == item.id })?.userRate)!)")
                                .font(font1)
                                .foregroundColor(.primary)
                            Text("/10")
                                .font(font2)
                                .fontWeight(.thin)
                                .foregroundColor(.primary)
                        }
                    }
                } else {
                    HStack(spacing: 5) {
                        Image(systemName: "star")
                        Text("Rate")
                    }
                    .font(noRatingFont)
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
