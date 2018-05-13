//
//  Configurator.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

struct MovieDBAPI {
    
    static let baseUrl: BaseURLType = .production
    static let apiKey = "060fe300cc5a08ba0515ed2dd96af98f"
}

public enum BaseURLType : String {
    case production = "https://api.themoviedb.org/3"
}
