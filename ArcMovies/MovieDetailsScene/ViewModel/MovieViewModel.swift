//
//  MovieViewModel.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

/// _MovieViewModel_ is a model representing an Movie with more information
struct MovieViewModel {
    let title: String
    let overview: String
    let releaseDate: String
    let genres: String
    let posterURL: URL?
}
