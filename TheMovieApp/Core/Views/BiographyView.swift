//
//  BiographyView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 22/06/2022.
//

import SwiftUI

struct BiographyView: View {
    
    let name: String
    let biography: String
    
    var body: some View {
        ScrollView {
            Text(biography)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Mini biography: \(name)")
    }
}

struct BiographyView_Previews: PreviewProvider {
    static var previews: some View {
        BiographyView(name: "Winona Rider", biography: "Biograpny in here.")
    }
}
