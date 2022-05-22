//
//  AllCastView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/04/2022.
//

import SwiftUI

struct AllCastView: View {
    
    let cast: [CastMember]
    
    let title: String
    let year: String
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                Text("\(cast.count) People")
                        .foregroundColor(.primary)
                    .font(.headline)
                Text("Sorted by Credit Order")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fontWeight(.light)
                }
                .padding(.leading)
                .padding(.vertical, 6)
                Spacer()
            }
            ScrollView {

            }
        }

    }
}

//struct AllCastView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCastView(cast: [dev.castMember, dev.castMember, dev.castMember])
//    }
//}
