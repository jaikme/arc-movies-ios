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
    let voteAverage: Double
    let posterURL: URL?
}

extension Movie : Parsable {
    
    private struct Constants {
        
        static let idKey = "id"
        static let titleKey = "title"
        static let posterPathKey = "poster_path"
        static let voteAverage = "vote_average"
    }
    
    static func fromJSON(json: [String: Any]) -> Movie? {

        guard
            let id = json[Constants.idKey] as? Int,
            let title = json[Constants.titleKey] as? String,
            let posterPath = json[Constants.posterPathKey] as? String,
            let voteAverage = json[Constants.voteAverage] as? Double,
            let posterUrl = URL(string: "\(MovieDBAPI.imageUrl.rawValue)\(posterPath)") else {
            return nil
        }
        
        return Movie(id: id, title: title, posterPath: posterPath, voteAverage: voteAverage, posterURL: posterUrl)
    }
}

