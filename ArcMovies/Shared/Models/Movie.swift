//
//  Movie.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

// MARK: - Movie

/// _Movie_ is a model representation of a MovieDB
struct Movie {
    
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let posterURL: URL?
}

extension Movie : Parsable {
    
    private struct Constants {
        
        static let idKey = "id"
        static let titleKey = "title"
        static let posterPathKey = "poster_path"
        static let overviewKey = "overview"
        static let voteAverage = "vote_average"
        static let releaseDateKey = "release_date"
    }
    
    static func fromJSON(json: [String: Any]) -> Movie? {

        guard
            let id = json[Constants.idKey] as? Int,
            let title = json[Constants.titleKey] as? String,
            let posterPath = json[Constants.posterPathKey] as? String,
            let overview = json[Constants.overviewKey] as? String,
            let voteAverage = json[Constants.voteAverage] as? Double,
            let releaseDate = json[Constants.releaseDateKey] as? String,
            let posterUrl = URL(string: "\(MovieDBAPI.imageUrl.rawValue)\(posterPath)") else {
            return nil
        }
        
        return Movie(id: id, title: title, posterPath: posterPath, overview: overview, voteAverage: voteAverage, releaseDate: releaseDate, posterURL: posterUrl)
    }
}

