//
//  PreviewProvider.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/04/2022.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let castMember = CastMember(adult: false, gender: 2, id: 819, knownForDepartment: "Acting", name: "Edward Norton", originalName: "Edward Norton", popularity: 7.861, profilePath: "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg", castId: 4, character: "The Narrator", creditId: "52fe4250c3a36847f80149f3", order: 0)
    
    let crewMember = CrewMember(adult: false, gender: 1, id: 119293, knownForDepartment: "Directing", name: "Tarik Saleh", originalName: "Tarik Saleh", popularity: 4.778, profilePath: "/6sZK0JLzcjgEmG8uxvAIdoGFOCH.jpg", creditId: "5d9fd91fae366800131f5e22", department: "Directing", job: "Director")
    
//    let itemDetails = ItemDetails(adult: false, backdropPath: "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg", budget: 63000000, genres: [Genre(id: 18, name: "Drama")], homepage: "", id: 550, originalLanguage: "en", originalTitle: "Fight Club", overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.", popularity: 0.5, posterPath: nil, productionCompanies: [ProductionCompany(name: "Regency Enterprises", id: <#T##Int#>, logoPath: <#T##String?#>, originCountry: <#T##String#>)], productionCountries: <#T##[Country]#>, releaseDate: <#T##String#>, revenue: <#T##Int#>, runtime: <#T##Int?#>, spokenLanguages: <#T##[Language]#>, status: <#T##String#>, tagline: <#T##String?#>, title: <#T##String#>, video: <#T##Bool#>, voteAverage: <#T##Double#>, voteCount: <#T##Int#>)
    
    let person = PersonDetails (birthday: "1963-12-18", knownForDepartment: "Acting", deathday: nil, id: 287, name: "Brat Pitt", alsoKnownAs: [], gender: 2, biography: "William Bradley \"Brad\" Pitt (born December 18, 1963) is an American actor and film producer. Pitt has received two Academy Award nominations and four Golden Globe Award nominations, winning one. He has been described as one of the world's most attractive men, a label for which he has received substantial media attention. Pitt began his acting career with television guest appearances, including a role on the CBS prime-time soap opera Dallas in 1987. He later gained recognition as the cowboy hitchhiker who seduces Geena Davis's character in the 1991 road movie Thelma & Louise. Pitt's first leading roles in big-budget productions came with A River Runs Through It (1992) and Interview with the Vampire (1994). He was cast opposite Anthony Hopkins in the 1994 drama Legends of the Fall, which earned him his first Golden Globe nomination. In 1995 he gave critically acclaimed performances in the crime thriller Seven and the science fiction film 12 Monkeys, the latter securing him a Golden Globe Award for Best Supporting Actor and an Academy Award nomination.\n\nFour years later, in 1999, Pitt starred in the cult hit Fight Club. He then starred in the major international hit as Rusty Ryan in Ocean's Eleven (2001) and its sequels, Ocean's Twelve (2004) and Ocean's Thirteen (2007). His greatest commercial successes have been Troy (2004) and Mr. & Mrs. Smith (2005).\n\nPitt received his second Academy Award nomination for his title role performance in the 2008 film The Curious Case of Benjamin Button. Following a high-profile relationship with actress Gwyneth Paltrow, Pitt was married to actress Jennifer Aniston for five years. Pitt lives with actress Angelina Jolie in a relationship that has generated wide publicity. He and Jolie have six children—Maddox, Pax, Zahara, Shiloh, Knox, and Vivienne.\n\nSince beginning his relationship with Jolie, he has become increasingly involved in social issues both in the United States and internationally. Pitt owns a production company named Plan B Entertainment, whose productions include the 2007 Academy Award winning Best Picture, The Departed.", popularity: 10647, placeOfBirth: "Shawnee, Oklahoma, USA", profilePath: "/kU3B75TyRiCgE270EyZnHjfivoq.jpg", adult: false, imdbID: "nm0000093", homepage: nil, character: nil)
    
    let genre = Genre(id: 18, name: "Drama")
    
    let posterURL = URL(string: "https://image.tmdb.org/t/p/original/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg")
}
