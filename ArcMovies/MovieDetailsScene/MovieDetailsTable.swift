//
//  MovieDetailsTable.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

final class MovieDetailsTable : UITableView {
    
    @IBOutlet private weak var Poster: UIImageView!
    
    var movieDetails: MovieViewModel?
}
