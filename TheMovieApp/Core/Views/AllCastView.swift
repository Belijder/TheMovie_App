//
//  AllCastView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/04/2022.
//

import SwiftUI

struct AllCastView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var movieDataService: MovieDataService
    
    let cast: [CastMember]
    let crew: [CrewMember]
    let title: String
    let date: String
    
    var body: some View {
        
        VStack {
            navigationBar
            peopleCounter
            ScrollView {
                ForEach(cast) { person in
                    CastCellView(movieDataService: movieDataService, person: person)
                }
                
            }
        }

    }
}

struct AllCastView_Previews: PreviewProvider {
    static var previews: some View {
        AllCastView(movieDataService: MovieDataService(), cast: [dev.castMember, dev.castMember, dev.castMember], crew: [dev.crewMember, dev.crewMember, dev.crewMember], title: "Movie", date: "")
    }
}

extension AllCastView {
    private var navigationBar: some View {
        ZStack {
            Text("All Cast")
                .foregroundColor(.primary)
                .bold()
            HStack {
            Image(systemName: "chevron.backward")
                .padding()
                .foregroundColor(.primary)
                .onTapGesture {
                    dismiss()
                }
                Spacer()
                
            }
        }
    }
    
    private var peopleCounter: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
            Text("\(cast.count) People")
                    .foregroundColor(.primary)
                .font(.headline)
            Text("Sorted by Credit Order")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fontWeight(.light)
            }
            .padding(.leading)
            .padding(.vertical, 6)
            Spacer()
        }
    }
}
