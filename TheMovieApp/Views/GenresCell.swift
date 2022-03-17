//
//  GenresCell.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 17/03/2022.
//

import SwiftUI

struct GenresCell: View {
    
    @State var genresNames: [String]
    
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 5) {
                ForEach(genresNames, id: \.self) { genre in
                    Text(genre)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 4).strokeBorder())   
                }
            }
        }
    }
    
}

struct GenresCell_Previews: PreviewProvider {
    static var previews: some View {
        GenresCell(genresNames: [])
    }
}
