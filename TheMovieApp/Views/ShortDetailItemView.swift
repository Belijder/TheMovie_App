//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 09/03/2022.
//

import SwiftUI

struct ShortDetailItemView: View {
    
    var itemIds: [Int]
    
    @StateObject var shortDetailItemViewViewModel = ShortDetailItemViewViewModel()

    var body: some View {
        
        ScrollView(.horizontal) {
            switch shortDetailItemViewViewModel.items {
            case .success(let items):
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(items, id: \.id) { item in
                            ShortDetailItemCell(item: item)
                        }
                    }
                    .padding(.leading, 8)
                }
            case .none:
                ProgressView()
            case .failure(let error):
                Text(error.localizedDescription)
            }
            
        }.task {
            shortDetailItemViewViewModel.items = await shortDetailItemViewViewModel.fetchitems(for: itemIds)
        }
    }
    
//    init(itemIds: [Int]) {
//        Task {
//            await shortDetailItemViewViewModel.fetchitems(for: itemIds)
//        }
//    }
}

struct ShortDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemView(itemIds: [1, 2])
    }
}
