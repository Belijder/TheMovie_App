//
//  CastMemberDetailView.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 13/06/2022.
//

import SwiftUI

struct CastMemberDetailView: View {
    
    let person: PersonDetails
    
    var body: some View {
        Text(person.name)
    }
}

struct CastMemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CastMemberDetailView(person: dev.person)
    }
}
