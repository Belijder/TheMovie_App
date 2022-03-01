//
//  ContentView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/02/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainViewVM = MainViewViewModel()
    
    @State var url = URL(string: "")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HeadLineRow(context: "Popular Movies")
                    .padding(.leading, 8)
                switch mainViewVM.popularMovies {
                case .success(let movies):
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(movies) { movie in
                                PortraitStyleMovieCell(movie: movie)
                            }
                        }
                        .padding(.leading, 8)
                    }
                case .failure(let error):
                    Text(error.localizedDescription)
                case .none:
                    ProgressView()
                }
            }
            .padding(.init(top: 5, leading: 0, bottom: 15, trailing: 0))
            .background(alignment: .center) {
                Color.secondary.opacity(0.1)
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(url: URL(string: "")!)
    }
}
