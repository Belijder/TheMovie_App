//
//  PopularMovieView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 27/02/2022.
//

import SwiftUI

struct PopularMovieCell: View {
    
    let movie: PopularMovie
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PopularMovieView_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieCell(movie: PopularMovie.example)
    }
}
