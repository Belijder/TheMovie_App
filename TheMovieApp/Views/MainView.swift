//
//  ContentView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/02/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var mainViewVM = MainViewViewModel()
    
    var body: some View {
        VStack {
            Text("Popular Movies")
            switch mainViewVM.popularMovies {
            case .success(let movies):
                List(movies, id:\.id) { movie in
                    Text(movie.title)
                }
            case .failure(let error):
                Text(error.localizedDescription)
            case .none:
                ProgressView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
