//
//  ShortDetailItemView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 07/03/2022.
//

import SwiftUI

struct ShortDetailItemCell: View {
    
    let item: ItemDetails
    
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Text(item.title)
                        .padding(50)
                    Spacer()
                }
            }
            .background(Color.yellow.opacity(0.5))
            .frame(width: UIScreen.main.bounds.width * 0.9)
                
                
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
            
    }
}


struct ShortDetailItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ShortDetailItemCell(item: ItemDetails.example)
    }
}
