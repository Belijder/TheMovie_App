//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 09/03/2022.
//

import SwiftUI
import Introspect

struct ShortDetailItemView: View {
    
    var itemIds: [Int]
    @State var currentItem: Int
    @State var scrolltoItem = 0
    
    @StateObject var shortDetailItemViewViewModel = ShortDetailItemViewViewModel()

    var body: some View {
        ZStack {
            Color.secondary.opacity(0.1)
                .ignoresSafeArea(.all)
            VStack {
                switch shortDetailItemViewViewModel.items {
                case .success(let items):
                    ScrollView(.horizontal) {
                        ScrollViewReader { proxy in
                            LazyHStack(spacing:0) {
                                ForEach(0..<items.count) { index in
                                    ShortDetailItemCell(backdropPath: items[index].backdropPath, item: items[index])
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
                    //.padding(.leading, currentItem == 0 ? UIScreen.main.bounds.width * 0.05 : 0)
                case .none:
                    ProgressView()
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
        ShortDetailItemView(itemIds: [1, 2], currentItem: 1)
    }
}
