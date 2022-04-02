//
//  CastMemberCapsule.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 31/03/2022.
//

import SwiftUI

struct CastMemberCapsule: View {
    
    let castMember: CastMember
    
    var body: some View {
        if castMember.profilePath != nil {
            HStack(alignment: .center, spacing: 8) {
                AsyncImage(url: URL(string: FetchManager.shared.imageBaseURL + castMember.profilePath!)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } placeholder: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.secondary)
                            .frame(width: 40, height: 40)
                        ProgressView()
                    }
                    
                }
                Text(castMember.name)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .padding(.trailing, 10)
            }
            .background(UITraitCollection.current.userInterfaceStyle == .dark ? Color.secondary.opacity(0.2) : Color.secondary.opacity(0.05))
            .clipShape(Capsule())
            .padding(6)
        } else {
            Text(castMember.name)
                .frame(height: 40)
                .padding(.horizontal)
                .background(UITraitCollection.current.userInterfaceStyle == .dark ? Color.secondary : Color.white)
                .clipShape(Capsule())
                .padding(6)
        }
    }
}

struct CastMemberCapsule_Previews: PreviewProvider {
    static var previews: some View {
        CastMemberCapsule(castMember: CastMember(adult: true, gender: 2, id: 819, knownForDepartment: "Acting", name: "Edward Norton", originalName: "Edward Norton", popularity: 7.861, profilePath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg", castId: 4, character: "Tyler Durden", creditId: "52fe4250c3a36847f80149f7", order: 1))
    }
}
