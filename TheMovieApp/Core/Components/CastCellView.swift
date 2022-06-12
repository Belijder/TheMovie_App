//
//  PersonCellView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 12/06/2022.
//

import SwiftUI

struct CastCellView: View {
    
    @EnvironmentObject var favoritePersons: FavoritePersons
    
    let movieDataService: MovieDataService
    let person: CastMember
    @State private var personDetails = PersonDetails.empty
   
    @State private var url = URL(string: "")
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ZStack(alignment: .bottomLeading) {
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
                FavoriteButton(person: personDetails)
                }
            VStack(alignment: .leading) {
                Text(person.name)
                    .bold()
                    .foregroundColor(.primary)
                Text(person.character)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if personDetails.id > 0 {
                Image.init(systemName: "chevron.forward")
                    .foregroundColor(.primary)
                    .font(.headline)
                    .padding(8)
            }
        }
        .padding(8)
        .task {
            url = await movieDataService.getPathToProfileImageFor(id: person.id)
        }
        .task {
            personDetails = await favoritePersons.fetchPersonDetailsfor(id: person.id) ?? PersonDetails.empty
        }
    }
}

struct PersonCellView_Previews: PreviewProvider {
    static var previews: some View {
        CastCellView(movieDataService: MovieDataService(), person: dev.castMember)
    }
}
