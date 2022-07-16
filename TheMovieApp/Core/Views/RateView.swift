//
//  RateView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 29/06/2022.
//

import SwiftUI

struct RateView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    let movie: ItemDetails
    @State var rating: Int
    @State private var showProgressView = false
    let transaction = Transaction(animation: Animation.easeInOut(duration: 0.3))
    
//    init(movieDataService: MovieDataService, movie: ItemDetails) {
//        self._vm = StateObject(wrappedValue: RateViewModel(movieDataService: movieDataService, movie: movie))
//    }
    
    var body: some View {
        VStack(spacing: 40) {
            dismissButton
            poster
            question
            stars
            VStack(spacing: 20) {
            rateButton
                .disabled(rating == 0)
            removeButton
            }
            Spacer()
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .background(
            background
        )
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(movieDataService: MovieDataService(), movie: dev.itemDetails, rating: 5)
    }
}

extension RateView {
    private var dismissButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.primary)
                    .padding()
            }
            Spacer()
        }
    }
    
    private var background: some View {
        VStack {
            if movie.posterPath != nil {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + movie.posterPath!)) { image in
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
    
    private var poster: some View {
        ZStack {
            if movie.posterPath != nil {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + movie.posterPath!)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle().fill(Color.clear)
                        .ignoresSafeArea()
                }
                .frame(width:UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2 * 1.5)
            }
        }
    }
    
    private var question: some View {
        Text("How would you rate \(movie.title)?")
            .font(.title3)
            .bold()
            .foregroundColor(.primary)
            .padding(.horizontal, 20)
            .multilineTextAlignment(.center)
    }
    
    private var rateButton: some View {
        Button {
            coreDataManager.addRatedMovieEntity(id: movie.id, title: movie.title, posterPath: movie.posterPath ?? "", rate: rating, date: Date.now, voteAverage: movie.voteAverage, runtime: movie.runtime ?? 0, releaseDate: movie.releaseDate)
            dismiss()
        } label: {
            if rating == 0 {
                Text("Rate")
                    .foregroundColor(.primary)
                    .padding(8)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            } else {
                Text("Rate")
                    .foregroundColor(.white)
                    .padding(8)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }
    }
    
    private var stars: some View {
        HStack {
            ForEach(1..<11) { index in
                if index <= rating {
                    Image(systemName: "star.fill")
                        .font(.title3)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                rating = index
                            }
                        }
                } else {
                    Image(systemName: "star")
                        .font(.title3)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                rating = index
                            }
                        }
                }
            }
        }
    }
    
    private var removeButton: some View {
        ZStack {
            if coreDataManager.savedUserRatingsItems.contains(where: { $0.id == movie.id}) {
                Button {
                    coreDataManager.removeRatedMovieEntity(id: movie.id)
                    dismiss()
                } label: {
                    Text("Remove Rating")
                        .foregroundColor(.secondary)
                        .bold()
                }
            }
        }
    }
}
