//
//  FavoritePersonView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 14/07/2022.
//

import SwiftUI

struct FavoritePersonView: View {
    
    @StateObject var vm: FavoritePersonViewModel
    
    init(person: FavoriteModel, movieDataService: MovieDataService) {
        _vm = StateObject(wrappedValue: FavoritePersonViewModel(person: person, movieDataService: movieDataService))
    }
    
    var body: some View {
        if vm.personDetails != nil  {
            NavigationLink(destination: {
                CastMemberDetailView(person: vm.personDetails!, movieDataService: vm.movieDataService)
            }, label: {
                label
                    .task {
                        await vm.getURL()
                    }
                    .task {
                        await vm.getPersonDetails()
                    }
            })
        } else {
            label
                .task {
                    await vm.getURL()
                }
                .task {
                    await vm.getPersonDetails()
                }
        }
    }
}

struct FavoritePersonView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePersonView(person: FavoriteModel(id: dev.person.id, name: dev.person.name, placeOfBirth: dev.person.placeOfBirth, profilePath: dev.person.profilePath), movieDataService: MovieDataService())
    }
}

extension FavoritePersonView {
    private var profileImage: some View {
        AsyncImage(url: vm.url) { image in
                image
                    .resizable()
                    .frame(width: 160, height: 240)
                    .scaledToFill()
        } placeholder: {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.secondary)
                    .frame(width: 160, height: 240)
                Image(systemName: "person.fill")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
            }
        }
    }
    
    private var label: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                profileImage
                FavoriteButton(id: vm.person.id, name: vm.person.name, profilePath: vm.person.profilePath, placeOfBirth: vm.person.placeOfBirth)
                    .padding(5)
            }
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(vm.person.name)
                        .foregroundColor(.primary)
                        .font(.footnote)
                        .lineLimit(1)
                    Text(vm.person.placeOfBirth)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                        .lineLimit(1)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                Spacer()
            }
            .frame(width: 160)
            .background(alignment: .center) {
                Rectangle()
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    .foregroundColor(UITraitCollection.current.userInterfaceStyle == .dark ? Color.black : Color.white)
            }
        }
    }
}


