//
//  CastCellVertical.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/06/2022.
//

import SwiftUI

struct CastCellVertical: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @ObservedObject var movieDataService: MovieDataService
    
    @State private var url = URL(string: "")
    
    let castMember: CastMember
    
    var body: some View {
        VStack {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 150)
                    .scaledToFit()
                
            } placeholder: {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.secondary)
                        .frame(width: 100, height: 150)
                    Image(systemName: "person.fill")
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                }
            }
            Text(castMember.name)
                .font(.footnote)
                .foregroundColor(.primary)
                .lineLimit(2)
            Text(castMember.character)
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
        }
        .frame(width: 100)
        .task {
            url = await movieDataService.getPathToProfileImageFor(id: castMember.id)
        }
        
    }
}

struct CastCellVertical_Previews: PreviewProvider {
    static var previews: some View {
        CastCellVertical(movieDataService: MovieDataService(), castMember: dev.castMember)
    }
}
