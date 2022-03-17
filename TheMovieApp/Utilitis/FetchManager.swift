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
        case popularMovies = "/movie/popular"
        case images
        case details = "/movie/"
    }
    
    private let apiKey = "?api_key=1d1526d2d72c80f3656b73b8eeea4ee0"
    let baseURL = "https://api.themoviedb.org/3"
    
    let imageBaseURL = "https://image.tmdb.org/t/p/original"
    let youTubeBaseURL = "https://www.youtube.com/watch?v="
    let vimeoBaseURL = "https://vimeo.com/"
    
    
    func makeURL(with endPoint: EndPoints, id: Int?) -> URL {
        
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
            
        default:
            url = URL(string:"\(baseURL + endPoint.rawValue + apiKey)")!
        }
        
        return url!
    }
    
    func makePosterImageURL(movieId id: Int) async -> URL {
        var endpointPath = ""
        var images: Images
        let url = makeURL(with: .images, id: id)
//        print("URL is: \(url)")
        
        do {
            let response = try await URLSession.shared.decode(Images.self, from: url)
            images = response
            let posters = images.posters
            var englishPosters = posters.filter { $0.isoCode == "en" //&& $0.aspectRatio == 0.667
            }
            
            englishPosters.sort {
                $0.voteAverage > $1.voteAverage
            }
            
            
            if englishPosters.isEmpty {
                endpointPath = posters[0].filePath
            } else {
//                DO TESTÓW
//                print("Votes: \(englishPosters[1].voteCount), Average: \(englishPosters[1].voteAverage)")
//                print("English posters count: \(englishPosters.count)")
                endpointPath = englishPosters[0].filePath
            }
        } catch {
            print(error.localizedDescription)
        }
        
        let posterURL = URL(string: imageBaseURL + endpointPath)!
        
        return  posterURL
    }
    
    func makeBackdropImageURL(movieId id: Int) async -> URL {
        var endpointPath = ""
        var images: Images
        let url = makeURL(with: .images, id: id)
//        print("URL is: \(url)")
        
        do {
            let response = try await URLSession.shared.decode(Images.self, from: url)
            images = response
            let backdrops = images.backdrops
            var englishBackdrops = backdrops.filter { $0.isoCode == "en" //&& $0.aspectRatio == 0.667
            }
            
            englishBackdrops.sort {
                $0.voteAverage > $1.voteAverage
            }
            
            
            if englishBackdrops.isEmpty {
                endpointPath = backdrops[0].filePath
            } else {
//                DO TESTÓW
//                print("Votes: \(englishPosters[1].voteCount), Average: \(englishPosters[1].voteAverage)")
//                print("English posters count: \(englishPosters.count)")
                endpointPath = englishBackdrops[0].filePath
            }
        } catch {
            print(error.localizedDescription)
        }
        
        let posterURL = URL(string: imageBaseURL + endpointPath)!
        
        return  posterURL
    }
    
    
}
