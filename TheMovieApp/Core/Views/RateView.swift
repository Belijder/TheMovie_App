//
//  RateView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 29/06/2022.
//

import SwiftUI

struct RateView: View {
    
    @StateObject var vm: RateViewModel
    
    init(movieDataService: MovieDataService, movie: ItemDetails) {
        self._vm = StateObject(wrappedValue: RateViewModel(movieDataService: movieDataService, movie: movie))
    }
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .background(
            ZStack {
                background
            }
        )
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(movieDataService: MovieDataService(), movie: dev.itemDetails)
    }
}

extension RateView {
    private var background: some View {
        VStack {
            if vm.movie.posterPath != nil {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + vm.movie.posterPath!)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } placeholder: {
                    Rectangle().fill(UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white)
                        .ignoresSafeArea()
                }
            }
        }
    }
}
