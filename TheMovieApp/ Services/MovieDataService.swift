//
//  MovieDataService.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/04/2022.
//

import Foundation

class MovieDataService {
    
    static let shared = MovieDataService()
    
    func makePosterImageURL(movieId id: Int) async -> URL {
        var endpointPath = ""
        var images: Images
        let url = FetchManager.shared.makeURL(with: .images, id: id)
        
        do {
            let response = try await URLSession.shared.decode(Images.self, from: url)
            images = response
            let posters = images.posters
            var englishPosters = posters.filter { $0.isoCode == "en" //&& $0.aspectRatio == 0.667
            }
            
            englishPosters.sort { $0.voteAverage > $1.voteAverage }
            
            
            if englishPosters.isEmpty {
                endpointPath = posters[0].filePath
            } else {
                endpointPath = englishPosters[0].filePath
            }
        } catch {
            print(error.localizedDescription)
        }
        
        let posterURL = URL(string: FetchManager.shared.imageBaseURL + endpointPath)!
        
        return  posterURL
    }
    
    func makeBackdropImageURL(movieId id: Int) async -> URL {
        var endpointPath = ""
        var images: Images
        let url = FetchManager.shared.makeURL(with: .images, id: id)
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
                endpointPath = englishBackdrops[0].filePath
            }
        } catch {
            print(error.localizedDescription)
        }
        
        let posterURL = URL(string: FetchManager.shared.imageBaseURL + endpointPath)!
        
        return  posterURL
    }
    
    func fetchCreditsfor(movie: Int) async -> Credits {
        do {
            let url = FetchManager.shared.makeURL(with: .credits, id: movie)
            let response = try await URLSession.shared.decode(Credits.self, from: url)
            return response
        } catch {
            print("Error when try to fetch PopularMovie array: \(error)")
            return Credits.example
        }
    }
    
    func makeTopCast(for movie: Int) async -> [CastMember] {
        let credits = await fetchCreditsfor(movie: movie)
        var cast = credits.cast
        cast.sort { $0.order < $1.order}
        let top4 = cast.prefix(4)
        let returnValue = Array(top4)
        return returnValue
  
    }
    
    func fetchReviews(movieID: Int) async -> Reviews {
        do {
            let url = FetchManager.shared.makeURL(with: .reviews, id: movieID)
            let response = try await URLSession.shared.decode(Reviews.self, from: url)
            return response
        } catch {
            print("Error when try to fetch Reviews: \(error.localizedDescription)")
            return Reviews.example
        }
    }
}
