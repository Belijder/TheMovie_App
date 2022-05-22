//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 09/03/2022.
//

import SwiftUI
import Introspect

struct ShortDetailItemView: View {
    
    let title: String
    
    var itemIds: [Int]
    @State var currentItem: Int
    @State var scrolltoItem = 0
    @Environment(\.dismiss) var dismiss
    
    
    @StateObject var shortDetailItemViewViewModel = ShortDetailItemViewViewModel()

    var body: some View {
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
                switch shortDetailItemViewViewModel.items {
                case .success(let items):
                    ScrollView(.horizontal) {
                        ScrollViewReader { proxy in
                            LazyHStack(spacing:0) {
                                ForEach(0..<items.count) { index in
                                    ShortDetailItemCell(topCastArray: shortDetailItemViewViewModel.topCasts[index], backdropPath: items[index].backdropPath, item: items[index], reviews: shortDetailItemViewViewModel.reviews[items[index].title] ?? Reviews.example)
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
                case .none:
                    VStack{
                    Spacer()
                    ProgressView()
                    Spacer()
                    }
                case .failure(let error):
                    Text("Nie działa bo: \(error.localizedDescription)")
                }
            }.task {
                shortDetailItemViewViewModel.items = await shortDetailItemViewViewModel.fetchitems(for: itemIds)
            }
        }
        
    }
}

struct ShortDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemView(title: "Popular Movies", itemIds: [1, 2], currentItem: 1)
    }
}
