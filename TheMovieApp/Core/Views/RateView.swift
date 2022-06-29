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
            if vm.movie.posterPath != nil {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + vm.movie.posterPath!)) { image in
                    image
                        .resizable()
                        .frame(width:UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2 * 1.5)
                        .scaledToFit()
                } placeholder: {
                    Rectangle().fill(UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white)
                        .ignoresSafeArea()
                }
            }
            Text("How would you rate \(vm.movie.title)?")
                .font(.title3)
                .bold()
                .foregroundColor(.primary)
            
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
