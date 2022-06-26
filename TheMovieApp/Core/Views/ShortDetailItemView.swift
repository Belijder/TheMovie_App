//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 09/03/2022.
//

import SwiftUI
import Introspect

struct ShortDetailItemView: View {
    
    init(title: String, items: [ItemDetails], currentItem: Int, movieDataService: MovieDataService) {
        self.title = title
        self.items = items
        _currentItem = State(wrappedValue: currentItem)
        _shortDetailItemViewViewModel = StateObject(wrappedValue: ShortDetailItemViewViewModel(items: items))
        _movieDataService = ObservedObject(wrappedValue: movieDataService)
        
    }
    @ObservedObject var movieDataService: MovieDataService
    let title: String
    
    let items: [ItemDetails]
    @State var currentItem: Int
    @State var scrolltoItem = 0
    @Environment(\.dismiss) var dismiss
    
    
    @StateObject var shortDetailItemViewViewModel: ShortDetailItemViewViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.secondary.opacity(0.1)
                    .ignoresSafeArea(.all)
                VStack {
                    ZStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Text(title)
                                .foregroundColor(.primary)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(6)
                            Spacer()
                        }
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.primary)
                                .font(.title3)
                                .padding(.leading)
                        }
                        
                    }
                    if shortDetailItemViewViewModel.isProgresViewEnabled {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView(.horizontal) {
                            ScrollViewReader { proxy in
                                LazyHStack(spacing:0) {
                                    ForEach(0..<20) { index in
                                        ShortDetailItemCell(movieDataService: movieDataService, topCastArray: shortDetailItemViewViewModel.topCasts[index], backdropPath: items[index].backdropPath, credits: shortDetailItemViewViewModel.credits[index], item: items[index], reviews: shortDetailItemViewViewModel.reviews[items[index].id] ?? Reviews.example)
                                            .id(index)
                                    }
                                    .onChange(of: scrolltoItem) { value in
                                        proxy.scrollTo(value, anchor: .center)
                                    }
                                    .onAppear {
                                        scrolltoItem = currentItem
                                    }
                                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                                    
                                }
                                
                            }
                        }
                        .introspectScrollView { scrollView in
                            scrollView.isPagingEnabled = true
                        }
                    }
                }.task {
                    await shortDetailItemViewViewModel.fetchCastAndReviews()
                }
                .navigationBarTitle("Recomended Films")
                .navigationBarHidden(true)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                                    // this sets the screen title in the navigation bar, when the screen is visible
                                    Text("dkd")
                                }
                }
            }
        }
        
    }
}

struct ShortDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemView(title: "Popular Movies", items: [], currentItem: 1, movieDataService: MovieDataService())
    }
}
