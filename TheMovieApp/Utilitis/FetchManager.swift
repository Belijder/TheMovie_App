//
//  FetchManager.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 26/02/2022.
//

import Foundation
import SwiftUI

struct FetchManager {
    
    static let shared = FetchManager()
    
    enum EndPoints: String {
        case genre = "/genre/movie/list"
        case movie = "/movie/"
        case popularMovies = "/movie/popular"
    }
    
    private let apiKey = "?api_key=1d1526d2d72c80f3656b73b8eeea4ee0"
    let baseURL = "https://api.themoviedb.org/3"
    
    func makeURL(with endPoint: EndPoints, id: Int?) -> URL {
        
        var url = URL(string: "")
        
        switch endPoint {
        case .movie:
            if let id = id {
                url = URL(string:"\(baseURL + endPoint.rawValue + String(id) + apiKey)")!
            }
        default:
            url = URL(string:"\(baseURL + endPoint.rawValue + apiKey)")!
        }
        
        return url!
    }
    
    
}
