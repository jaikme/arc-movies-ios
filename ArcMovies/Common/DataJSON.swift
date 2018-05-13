//
//  DataJSONParseable.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import Foundation

extension Data {
    
    /// Deserializing this data object into a json dictionary if possible
    ///
    /// - returns: The deserialized dictionary if possible, otherwise nil
    func jsonDictionary() -> [String: Any]? {
        
        do {
            
            let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
            return json
        } catch {
            
            return nil
        }
    }
}
