//
//  MovieViewModel.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

// MARK: - MoviesViewModel

/// _MoviesViewModel_ is a model representing an Movie with title and poster image url
struct MoviesViewModel {
    
    let title: String
    let posterURL: URL?
}
