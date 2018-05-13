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
    
    let id: String
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
}

extension Movie {
    
    private struct Constants {
        
        static let idKey = "id"
        static let titleKey = "title"
        static let posterPathKey = "poster_path"
        static let overviewKey = "overview"
        static let releaseDateKey = "release_date"
    }
}

