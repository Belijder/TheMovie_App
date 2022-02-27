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
        case images
    }
    
    private let apiKey = "?api_key=1d1526d2d72c80f3656b73b8eeea4ee0"
    let baseURL = "https://api.themoviedb.org/3"
    
    let imageBaseURL = "https://image.tmdb.org/t/p/original"
    
    
    func makeURL(with endPoint: EndPoints, id: Int?) -> URL {
        
        var url = URL(string: "")
        
        switch endPoint {
        case .movie:
            if let id = id {
                url = URL(string:"\(baseURL + endPoint.rawValue + String(id) + apiKey)")!
            }
            
        case .images:
            if let id = id {
                url = URL(string: "\(baseURL)/movie/\(id)/images\(apiKey)")
            }
        default:
            url = URL(string:"\(baseURL + endPoint.rawValue + apiKey)")!
        }
        
        return url!
    }
    
    func makePosterImageURL(movie id: Int) async -> URL
    {
        var endpointPath = ""
        var images: Images
        let url = makeURL(with: .images, id: id)
        print("URL is: \(url)")
        
        do {
            let response = try await URLSession.shared.decode(Images.self, from: url)
            images = response
            let posters = images.posters
            var englishPosters = posters.filter { $0.isoCode == "en" }
            englishPosters.sort {
                $0.voteAverage > $1.voteAverage
            }
            
            if englishPosters.isEmpty {
                endpointPath = posters[1].filePath
            } else {
//                DO TESTÓW
//                print("Votes: \(englishPosters[1].voteCount), Average: \(englishPosters[1].voteAverage)")
//                print("English posters count: \(englishPosters.count)")
                endpointPath = englishPosters[1].filePath
            }
        } catch {
            print("Tu się sypie")
            print(error.localizedDescription)
        }
        
        let posterURL = URL(string: imageBaseURL + endpointPath)!
        
        return  posterURL
       
    
    }
    
    
}
