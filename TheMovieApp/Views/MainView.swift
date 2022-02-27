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
        VStack {
            Text("Popular Movies")
//            switch mainViewVM.popularMovies {
//            case .success(let movies):
//                List(movies, id:\.id) { movie in
//                    Text(movie.title)
//                }
//            case .failure(let error):
//                Text(error.localizedDescription)
//            case .none:
//                ProgressView()
//            }
            
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
        }.task {
            url = await FetchManager.shared.makePosterImageURL(movie: 324668)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(url: URL(string: "")!)
    }
}
