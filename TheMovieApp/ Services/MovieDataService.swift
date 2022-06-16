//
//  MovieDataService.swift
//  TheMovieApp
//
//  Created by Kamila Mroziewska on 04/04/2022.
//

import Foundation

actor MovieDataService: ObservableObject {
    
    //static let shared = MovieDataService()
    
    func fetchPopularMovies() async -> [PopularMovie] {
        var movies = [PopularMovie]()
        if let url = FetchManager.shared.makeURL(with: .popularMovies, id: nil) {
            do {
                let response = try await URLSession.shared.decode(PopularMovies.self, from: url)
                movies = response.results
            } catch {
                print("Error when try to fetch PopularMovie array: \(error)")
            }
             return movies
        } else {
            print("Bad URL to fetch Popular Movies array: \(URLError.badURL)")
            return []
        }
    }
    
    func fetchPopularMoviesIDs(from array: [ItemDetails]) async -> [Int] {
        var popularMoviesIDs: [Int] = []
        for movie in array {
            popularMoviesIDs.append(movie.id)
        }
        return popularMoviesIDs
    }
        
    func fetchPopularMoviesDetails(from popularMovies: [PopularMovie]) async -> [ItemDetails] {
        var result: [ItemDetails] = []
        for movie in popularMovies {
            if let url = FetchManager.shared.makeURL(with: .details, id: movie.id) {
                    do {
                        let response = try await URLSession.shared.decode(ItemDetails.self, from: url)
                        result.append(response)
                        
                    } catch {
                        print("Error when try to fetch ItemDetails array: \(error)")
                    }
            } else {
                print("Bad URL to fetch Item Details for \(movie.title), id: \(movie.id): \(URLError.badURL)")
            }
        }
        return result
    }
    
    /**
            This function fetch all posters from endpoint path. Then filters them linguistically, selecting only the ones in English, then sorts them from the highest ranked and returns the first result. If there is no poster in English, it returns the highest ranked poster in any language.
     */
    func makePosterImageURL(movieId id: Int) async -> URL? {
        var endpointPath = ""
        var images: Images
        if let url = FetchManager.shared.makeURL(with: .images, id: id) {
            do {
                let response = try await URLSession.shared.decode(Images.self, from: url)
                images = response
                var posters = images.posters
                var englishPosters = posters.filter { $0.isoCode == "en" //&& $0.aspectRatio == 0.667
                }
                
                englishPosters.sort { $0.voteAverage > $1.voteAverage }
                
                
                if englishPosters.isEmpty {
                    posters.sort { $0.voteAverage > $1.voteAverage }
                    endpointPath = posters[0].filePath
                } else {
                    endpointPath = englishPosters[0].filePath
                }
            } catch {
                print(error.localizedDescription)
            }
            let posterURL = URL(string: FetchManager.shared.imageBaseURL + endpointPath)!
            return  posterURL
        } else {
            return nil
        }
    }
    
    func makeBackdropImageURL(movieId id: Int) async -> URL? {
        var endpointPath = ""
        var images: Images
        if let url = FetchManager.shared.makeURL(with: .images, id: id) {
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
        }
        let posterURL = URL(string: FetchManager.shared.imageBaseURL + endpointPath)
        return posterURL
    }
    
    func fetchCreditsfor(movieID: Int) async -> Credits {
        if let url = FetchManager.shared.makeURL(with: .credits, id: movieID) {
            do {
                let response = try await URLSession.shared.decode(Credits.self, from: url)
                return response
            } catch {
                print("Error when try to fetch PopularMovie array: \(error)")
                return Credits.example
            }
        } else {
            print("Bad URL to fetch credits for movieID: \(movieID): \(URLError.badURL)")
            return Credits(id: 1, cast: [], crew: [])
        }
    }
    
    func makeTopCast(for movie: Int) async -> [CastMember] {
        let credits = await fetchCreditsfor(movieID: movie)
        var cast = credits.cast
        cast.sort { $0.order < $1.order}
        let top4 = cast.prefix(4)
        let returnValue = Array(top4)
        return returnValue
    }
    
    func fetchReviews(movieID: Int) async -> Reviews {
        
        if let url = FetchManager.shared.makeURL(with: .reviews, id: movieID) {
            do {
                let response = try await URLSession.shared.decode(Reviews.self, from: url)
                return response
            } catch {
                print("Error when try to fetch Reviews: \(error.localizedDescription)")
                return Reviews.example
            }
        } else {
            print("Bad URL to fetch credits for movieID: \(movieID): \(URLError.badURL)")
            return Reviews(id: 1, page: 1, results: [], totalPages: 1, totalResults: 1)
        }
    }
    
    func fetchPersonProfileImages(id: Int) async -> Person? {
        if let url = FetchManager.shared.makeURL(with: .personProfiles, id: id) {
            do {
                let response = try await URLSession.shared.decode(Person.self, from: url)
                return response
            } catch let error {
                print(error)
                return nil
            }
        } else {
            print("Bad URL \(URLError.badURL)")
            return nil
        }
    }
    
    func getPathToProfileImageFor(id: Int) async -> URL? {
        if let person = await fetchPersonProfileImages(id: id) {
            var profiles = person.profiles
            profiles.sort {
                $0.voteAverage > $1.voteAverage
            }
            
            let filteredProfiles = profiles.filter {
                $0.aspectRatio == 0.666666666666667
            }
            
            var endpointPath = ""
            
            if !filteredProfiles.isEmpty {
                endpointPath = filteredProfiles[0].filePath
            } else if !profiles.isEmpty {
                endpointPath = profiles[0].filePath
            } else {
                return nil
            }
            
            let url = URL(string: FetchManager.shared.imageBaseURL + endpointPath)
            return url
            
        } else {
            return nil
        }
    }
    
    func fetchPersonDetailsfor(id: Int) async -> PersonDetails? {
        if let url = FetchManager.shared.makeURL(with: .personDetails, id: id) {
            do {
                let response = try await URLSession.shared.decode(PersonDetails.self, from: url)
                return response
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
}
