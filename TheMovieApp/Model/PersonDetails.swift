//
//  Person.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 11/06/2022.
//

import Foundation

struct PersonDetails: Codable, Equatable, Identifiable {
    let birthday, knownForDepartment: String
    let deathday: String?
    let id: Int
    let name: String
    let alsoKnownAs: [String]
    let gender: Int
    let biography: String
    let popularity: Double
    let placeOfBirth, profilePath: String
    let adult: Bool
    let imdbID: String
    let homepage: String?
    
    var character: String?

    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case deathday, id, name
        case alsoKnownAs = "also_known_as"
        case gender, biography, popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case adult
        case imdbID = "imdb_id"
        case homepage
        case character
    }
    
    static let example = PersonDetails(birthday: "1963-12-18", knownForDepartment: "Acting", deathday: nil, id: 287, name: "Brat Pitt", alsoKnownAs: [], gender: 2, biography: "William Bradley \"Brad\" Pitt (born December 18, 1963) is an American actor and film producer. Pitt has received two Academy Award nominations and four Golden Globe Award nominations, winning one. He has been described as one of the world's most attractive men, a label for which he has received substantial media attention. Pitt began his acting career with television guest appearances, including a role on the CBS prime-time soap opera Dallas in 1987. He later gained recognition as the cowboy hitchhiker who seduces Geena Davis's character in the 1991 road movie Thelma & Louise. Pitt's first leading roles in big-budget productions came with A River Runs Through It (1992) and Interview with the Vampire (1994). He was cast opposite Anthony Hopkins in the 1994 drama Legends of the Fall, which earned him his first Golden Globe nomination. In 1995 he gave critically acclaimed performances in the crime thriller Seven and the science fiction film 12 Monkeys, the latter securing him a Golden Globe Award for Best Supporting Actor and an Academy Award nomination.\n\nFour years later, in 1999, Pitt starred in the cult hit Fight Club. He then starred in the major international hit as Rusty Ryan in Ocean's Eleven (2001) and its sequels, Ocean's Twelve (2004) and Ocean's Thirteen (2007). His greatest commercial successes have been Troy (2004) and Mr. & Mrs. Smith (2005).\n\nPitt received his second Academy Award nomination for his title role performance in the 2008 film The Curious Case of Benjamin Button. Following a high-profile relationship with actress Gwyneth Paltrow, Pitt was married to actress Jennifer Aniston for five years. Pitt lives with actress Angelina Jolie in a relationship that has generated wide publicity. He and Jolie have six children—Maddox, Pax, Zahara, Shiloh, Knox, and Vivienne.\n\nSince beginning his relationship with Jolie, he has become increasingly involved in social issues both in the United States and internationally. Pitt owns a production company named Plan B Entertainment, whose productions include the 2007 Academy Award winning Best Picture, The Departed.", popularity: 10647, placeOfBirth: "Shawnee, Oklahoma, USA", profilePath: "/kU3B75TyRiCgE270EyZnHjfivoq.jpg", adult: false, imdbID: "nm0000093", homepage: nil, character: nil)
    
    static let empty = PersonDetails(birthday: "", knownForDepartment: "", deathday: "", id: 0, name: "", alsoKnownAs: [""], gender: 0, biography: "", popularity: 0, placeOfBirth: "", profilePath: "", adult: false, imdbID: "", homepage: "", character: nil)
}
