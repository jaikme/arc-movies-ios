//
//  MovieDetails.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

// MARK: - MovieDetails

/// _Movie_ is a model representation of movie details
struct MovieDetails {
    
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let genres: String
    let posterURL: URL?
}

extension MovieDetails : Parsable {
    
    private struct Constants {
        
        static let idKey = "id"
        static let titleKey = "title"
        static let posterPathKey = "backdrop_path"
        static let overviewKey = "overview"
        static let genresKey = "genres"
        static let genreKey = "name"
        static let releaseDateKey = "release_date"
    }
    
    static func fromJSON(json: [String: Any]) -> MovieDetails? {
        
        guard
            let id = json[Constants.idKey] as? Int,
            let title = json[Constants.titleKey] as? String,
            let posterPath = json[Constants.posterPathKey] as? String,
            let overview = json[Constants.overviewKey] as? String,
            let releaseDate = json[Constants.releaseDateKey] as? String,
            let posterUrl = URL(string: "\(MovieDBAPI.imageUrl.rawValue)\(posterPath)") else {
                return nil
        }
        
        var genresString = "Not defined"
        
        if let genresArray = json[Constants.genresKey] as? [[String: Any]] {
            
            let genres = genresArray.compactMap { (genresArray) -> String? in
               guard let genre = genresArray[Constants.genreKey] as? String else {
                    return nil
                }
                return genre
            }
            
            genresString = genres.joined(separator: ", ")
            
        }

        return MovieDetails(id: id, title: title, posterPath: posterPath, overview: overview, releaseDate: releaseDate, genres: genresString, posterURL: posterUrl)
    }
}

