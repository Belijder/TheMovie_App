//
//  AllCastView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/04/2022.
//

import SwiftUI

struct AllCastView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: AllCastViewModel

    var body: some View {
        VStack {
            navigationBar
            peopleCounter
            TextField("Search person...", text: $vm.searchText)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            ScrollView {
                LazyVStack {
                    ForEach(vm.filteredCast) { castMember in
                        if let index = vm.findIndexForPersonDetails(id: castMember.id) {
                            NavigationLink {
                                CastMemberDetailView(person: vm.personsDetailsWithCharacters[index], movieDataService: vm.movieDataService)
                            } label: {
                                ZStack(alignment: .trailing) {
                                    ZStack(alignment: .bottomLeading) {
                                        CastCellView(movieDataService: vm.movieDataService, person: castMember)
                                        FavoriteButton(id: vm.personsDetailsWithCharacters[index].id,
                                                       name: vm.personsDetailsWithCharacters[index].name,
                                                       profilePath: vm.personsDetailsWithCharacters[index].profilePath,
                                                       placeOfBirth: vm.personsDetailsWithCharacters[index].placeOfBirth
                                        )
                                        .padding(5)
                                    }
                                    Image(systemName: "chevron.forward")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                        .padding()
                                }
                            }
                        }
                        else {
                            CastCellView(movieDataService: vm.movieDataService, person: castMember)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("All Cast")
        .navigationBarHidden(true)
    }
    
    init(movieDataService: MovieDataService, cast: [CastMember], crew: [CrewMember], title: String, date: String) {
        self._vm = StateObject(wrappedValue: AllCastViewModel(movieDataService: movieDataService, cast: cast, crew: crew, date: date))
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
                Text("\(vm.cast.count) People")
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
