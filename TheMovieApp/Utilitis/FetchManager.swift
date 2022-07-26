//
//  FetchManager.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/02/2022.
//

import Foundation
import SwiftUI

final class FetchManager {
    static let shared = FetchManager()
    
    enum EndPoints: String {
        case genre = "/genre/movie/list"
        case popularMovies = "/movie/popular"
        case images
        case details = "/movie/"
        case credits
        case reviews
        case personDetails = "/person/"
        case personProfiles
        case movieCreditsforPerson = "/movie_credits"
        case topRatedMovies = "/movie/top_rated"
        case recommendations = "/recommendations"
    }
    
    enum SearchEndPoints: String {
        case movieSearch = "/search/movie"
    }
    
    let apiKey = "?api_key=1d1526d2d72c80f3656b73b8eeea4ee0"
    let baseURL = "https://api.themoviedb.org/3"
    let imageBaseURL = "https://image.tmdb.org/t/p/original"
    let youTubeBaseURL = "https://www.youtube.com/watch?v="
    let vimeoBaseURL = "https://vimeo.com/"
    
    func makeSearchURL(with endPoint: SearchEndPoints, query: String) -> URL? {
        var url = URL(string: "")
        if !query.isEmpty {
            switch endPoint {
            case .movieSearch:
                url = URL(string: "\(baseURL + endPoint.rawValue + apiKey)&query=\(query)")
            }
        }
        return url
    }
    
    func makeURL(with endPoint: EndPoints, id: Int?) -> URL? {
        var url = URL(string: "")
        switch endPoint {
        case .images:
            if let id = id {
                url = URL(string: "\(baseURL)/movie/\(id)/images\(apiKey)")
            }
        case .details:
            if let id = id {
                url = URL(string:"\(baseURL + endPoint.rawValue + String(id) + apiKey)")!
            }
        case .credits:
            if let id = id {
                url = URL(string: "\(baseURL)/movie/\(id)/credits\(apiKey)")
            }
        case .reviews:
            if let id = id {
                url = URL(string: "\(baseURL)/movie/\(id)/reviews\(apiKey)")
            }
        case .personDetails:
            if let id = id {
                url = URL(string: "\(baseURL + endPoint.rawValue + String(id) + apiKey)")
            }
        case .personProfiles:
            if let id = id {
                url = URL(string: "\(baseURL)/person/\(id)/images\(apiKey)")
            }
        case .movieCreditsforPerson:
            if let id = id {
                url = URL(string: "\(baseURL)/person/\(id)\(endPoint.rawValue)\(apiKey)")
            }
        case .topRatedMovies:
            url = URL(string: baseURL + endPoint.rawValue + apiKey)
        case .recommendations:
            if let id = id {
                url = URL(string: "\(baseURL)/movie/\(id)\(endPoint.rawValue)\(apiKey)" )
            }
        default:
            url = URL(string:"\(baseURL + endPoint.rawValue + apiKey)")!
        }
        return url
    }
}
