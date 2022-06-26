//
//  CastMemberDetailView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 13/06/2022.
//

import SwiftUI

struct CastMemberDetailView: View {
    
    @StateObject var vm: CastMemberDetailViewModel
    @EnvironmentObject var favoritePerons: FavoritePersons
    
    init(person: PersonDetails, movieDataService: MovieDataService) {
        self._vm = StateObject(wrappedValue: CastMemberDetailViewModel(person: person, movieDataService: movieDataService))
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 10) {
                name
                HStack(alignment: .center) {
                    profileImage
                    NavigationLink {
                        BiographyView(name: vm.personDetails.name, biography: vm.personDetails.biography)
                    } label: {
                        shortBiography
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                born
                if vm.personDetails.deathday != nil {
                    death
                }
                from
                addToFavoriteButton
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(alignment: .center) {
                Color.secondary.opacity(0.1)
            }
            
            VStack(alignment: .leading) {
                HeadLineRow(context: "Filmography")
                Text("KNOWN FOR")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
//                        ForEach(0..<vm.movieCredits.count, id: \.self) { index in
//                            FilmographyCell(movieDataservice: vm.movieDataService, movie: vm.movieCredits[index].1, character: vm.movieCredits[index].0)
//                        }
                        
                        ForEach(0..<vm.complexDetailsForCredits.count, id: \.self) { index in
                            NavigationLink {
                                LongDetailView(movieDataService: vm.movieDataService, topCastArray: vm.complexDetailsForCredits[index].topCastArray, backdropPath: vm.complexDetailsForCredits[index].backdropPath, credits: vm.complexDetailsForCredits[index].credits, itemDetails: vm.complexDetailsForCredits[index].itemDetails, reviews: vm.complexDetailsForCredits[index].reviews)
                            } label: {
                                FilmographyCell(movieDataservice: vm.movieDataService, movie: vm.complexDetailsForCredits[index].itemDetails, character: vm.complexDetailsForCredits[index].character)
                            }
                        }
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(alignment: .center) {
                Color.secondary.opacity(0.1)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(vm.personDetails.name)
    }
}

struct CastMemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CastMemberDetailView(person: dev.person, movieDataService: MovieDataService())
    }
}

extension CastMemberDetailView {
    private var name: some View {
        Text(vm.personDetails.name)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }
    private var profileImage: some View {
        VStack{
            if vm.profileURL != nil {
                AsyncImage(url: vm.profileURL) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 150)
                        .scaledToFit()
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.secondary)
                            .frame(width: 150, height: 150)
                        Image(systemName: "person.fill")
                            .foregroundColor(.primary)
                            .font(.largeTitle)
                    }
                }
            }
        }
    }
    private var shortBiography: some View {
        HStack {
            Text(vm.personDetails.biography)
                .frame(height: 150)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
            Image(systemName: "chevron.forward")
        }
    }
    
    private var born: some View {
        HStack {
            Text("Born:")
                .foregroundColor(.primary)
            Text(vm.personDetails.birthday)
                .foregroundColor(.secondary)
        }
    }
    
    private var death: some View {
            HStack {
                Text("Death:")
                    .foregroundColor(.primary)
                Text(vm.personDetails.birthday)
                    .foregroundColor(.secondary)
            }
    }
    private var from: some View {
        HStack {
            Text("From:")
                .foregroundColor(.primary)
            Text(vm.personDetails.placeOfBirth)
                .foregroundColor(.secondary)
        }
    }
    private var addToFavoriteButton: some View {
        VStack {
            if favoritePerons.items.contains(vm.personDetails) {
                Button {
                    favoritePerons.removeFromFavorite(item: vm.personDetails)
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "checkmark")
                        Text("Added to favorites")
                        Spacer()
                    }
                    .foregroundColor(.primary)
                    .padding(.leading)
                    .padding(.vertical, 8)
                    .buttonStyle(PlainButtonStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.primary, lineWidth: 3)
                            .foregroundColor(.primary)
                    )
                }
            } else {
                Button {
                    favoritePerons.addToFavorite(item: vm.personDetails)
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "plus")
                        Text("Add to favorites")
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .padding(.leading)
                    .padding(.vertical, 8)
                    .buttonStyle(PlainButtonStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.yellow)
                    )
                }
            }
        }
    }
}
