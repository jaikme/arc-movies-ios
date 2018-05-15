//
//  ImageStoreProtocol.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit


/// _ImageStoreProtocol_ is a protocol for image loading behaviours
protocol ImageStoreProtocol {
    
    /// Loads an image from the store given a URL
    ///
    /// - parameter url:        The URL of the image to load
    /// - parameter completion: The closure to trigger when the image loading completes
    func loadImage(url: URL, completion: @escaping (UIImage?, Error?) -> ())
}
