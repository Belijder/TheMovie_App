//
//  HeadLineView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 01/03/2022.
//

import SwiftUI

struct HeadLineRow: View {
    
    var context: String
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            Text("|")
                .foregroundColor(.yellow)
                .font(.largeTitle)
                .fontWeight(.black)
            Text(context)
                .foregroundColor(.primary)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
        }
    }
}

struct HeadLineView_Previews: PreviewProvider {
    static var previews: some View {
        HeadLineRow(context: "Popular Movies")
    }
}
