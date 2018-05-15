//
//  Parseable.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation


// MARK: - Parsable

/// _Parsable_ is a protocol to specify parsing behaviour
protocol Parsable {
    
    associatedtype T
    
    /// Converts a JSON dictionary into a generic object type T
    ///
    /// - parameter json: JSON dictionary
    ///
    /// - returns: The generic object type
    static func fromJSON(json: [String: Any]) -> T?
}
