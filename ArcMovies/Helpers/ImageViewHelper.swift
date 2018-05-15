//
//  ImageViewHelper.swift
//  ArcMovies
//
//  Created by Jaime Costa Marques on 13/05/18.
//  Copyright © 2018 Jaime Costa Marques. All rights reserved.
//

import UIKit

// MARK: - UIImageView

extension UIImageView {
    
    func setImageURL(url: URL?, placeholder: UIImage? = nil, completion: @escaping () -> Void) {
        
        guard let imageURL = url else {
            
            image = placeholder
            
            return
        }
        
        ImageManager.sharedInstance.loadImage(url: imageURL) { [weak self] image, error in
            guard let `self` = self else { return }
            self.image = image
            completion()
        }
    }
}
